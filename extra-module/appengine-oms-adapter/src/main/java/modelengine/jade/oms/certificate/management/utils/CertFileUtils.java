/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2024-2024. All rights reserved.
 */

package modelengine.jade.oms.certificate.management.utils;

import modelengine.fitframework.log.Logger;
import modelengine.jade.oms.certificate.management.service.impl.CertMgmtServiceImpl;
import modelengine.jade.oms.entity.FileEntity;

import org.apache.commons.io.FileUtils;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

/**
 * 文件处理工具类。
 *
 * @author 邱晓霞
 * @since 2024-11-28
 */
public class CertFileUtils {
    private static final Logger LOG = Logger.get(CertMgmtServiceImpl.class);

    /**
     * 递归删除文件夹中的所有文件和文件夹，同时删除根文件夹。
     *
     * @param dirPath 表示文件路径的 {@link String}。
     */
    public static void deleteDir(String dirPath) {
        FileUtils.deleteQuietly(modelengine.fitframework.util.FileUtils.canonicalize(dirPath));
    }

    /**
     * 将 src 目录或文件重命名为 target。
     *
     * @param srcPath 表示原文件或目录路径的 {@link String}。
     * @param targetPath 表示目标文件或目录的 {@link String}。
     */
    public static void renameDirAndFile(String srcPath, String targetPath) {
        File srcFile = new File(srcPath);
        File targetFile = new File(targetPath);
        if (targetFile.exists()) {
            if (targetFile.isDirectory()) {
                deleteDir(targetFile.getPath());
            } else {
                targetFile.delete();
            }
        }
        srcFile.renameTo(targetFile);
    }

    /**
     * 保存一个文本内容至文件中，以全部替换的方式。
     *
     * @param strContent 表示文本内容的 {@link String}。
     * @param path 表示文件路径的 {@link String}。
     */
    public static void saveStringToFile(String strContent, String path) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(path))) {
            writer.write(strContent);
        } catch (IOException e) {
            handleIOException("Failed to save file", e);
        }
    }

    /**
     * 对于 IOException 中的 FileNotFoundException 进行特殊处理不打印异常信息；
     * 对于普通的 IOException 打印异常信息。
     *
     * @param errorMsg 表示 debug 日志信息的 {@link String}。
     * @param e 表示异常对象的 {@link IOException}。
     */
    public static void handleIOException(String errorMsg, IOException e) {
        if (e instanceof FileNotFoundException) {
            LOG.error(errorMsg);
        } else {
            LOG.error(errorMsg, e);
        }
    }

    /**
     * 为文件赋予 600 的操作权限。
     *
     * @param file 表示待修改的文件的 {@link File}。
     * @return 表示修改结果的 {@code boolean}。
     */
    public static boolean grantRwPermissionOnlyToOwner(File file) {
        return file.setReadable(true, true) && file.setWritable(true, true) && file.setExecutable(false, true);
    }

    /**
     * 删除目标目录，并且处理 IO 异常。
     *
     * @param dir 表示待删除目录的 {@link File}。
     */
    public static void removeDir(File dir) {
        try {
            FileUtils.deleteDirectory(dir);
        } catch (IOException e) {
            handleIOException("Failed to delete directory", e);
        }
    }

    /**
     * 生成文件。
     *
     * @param fileName 表示文件名称的 {@link String}。
     * @param path 表示文件路径的 {@link String}。
     * @return 表示文件实体的 {@link FileEntity}。
     * @throws IOException 读取过程发生输入输出异常。
     */
    public static FileEntity fileToFileEntity(String fileName, String path) throws IOException {
        File file = new File(path);
        return new FileEntity(fileName, Files.newInputStream(Paths.get(path)), file.length());
    }

    /**
     * 读取文件内容为字符串
     *
     * @param filePath 文件路径
     * @return 字符串
     */
    public static String readFileToOneLineString(String filePath) {
        StringBuilder content = new StringBuilder();

        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                content.append(line);
            }
        } catch (IOException e) {
            handleIOException("Fail to read file as string", e);
        }
        return content.toString();
    }
}