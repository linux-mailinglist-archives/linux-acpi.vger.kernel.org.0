Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3802DA48
	for <lists+linux-acpi@lfdr.de>; Wed, 29 May 2019 12:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfE2KUU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 May 2019 06:20:20 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:53992 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726670AbfE2KUU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 29 May 2019 06:20:20 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4TAGKrl009723;
        Wed, 29 May 2019 05:19:55 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail3.cirrus.com ([87.246.76.56])
        by mx0a-001ae601.pphosted.com with ESMTP id 2sq340mnh0-1;
        Wed, 29 May 2019 05:19:55 -0500
Received: from EDIEX02.ad.cirrus.com (ediex02.ad.cirrus.com [198.61.84.81])
        by mail3.cirrus.com (Postfix) with ESMTP id A52C9614447B;
        Wed, 29 May 2019 05:20:36 -0500 (CDT)
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Wed, 29 May
 2019 11:19:54 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Wed, 29 May 2019 11:19:54 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 51FB444;
        Wed, 29 May 2019 11:19:54 +0100 (BST)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <lee.jones@linaro.org>,
        <rafael@kernel.org>, <gregkh@linuxfoundation.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <patches@opensource.cirrus.com>, <linux-acpi@vger.kernel.org>
Subject: [PATCH 1/6] device property: Add new array helper
Date:   Wed, 29 May 2019 11:19:49 +0100
Message-ID: <20190529101954.10438-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905290069
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It is fairly common to want to read an integer array property
that is composed of an unknown number of fixed size integer
groups. For example, say each group consists of three values
which correspond to the settings for one input on the device
and the driver supports several chips with different numbers
of inputs.

Add a new helper function to provide this functionality, it
differs for the existing helpers in that it allows reading a
smaller number of values than the full array size and checks
that the number of values read is a multiple of the group size.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/base/property.c  | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/property.h |  2 ++
 2 files changed, 50 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 348b37e64944c..656d21e01a648 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -133,6 +133,54 @@ int device_property_read_u32_array(struct device *dev, const char *propname,
 EXPORT_SYMBOL_GPL(device_property_read_u32_array);
 
 /**
+ * device_property_read_u32_2darray - return a 2d u32 array property of a device
+ * @dev: Device to get the property of
+ * @propname: Name of the property
+ * @val: The values are stored here or %NULL to return the number of values
+ * @nval: Size of the @val array
+ * @multiple: Number of entries in each block of data
+ *
+ * Function reads an array of u32 properties split up into fixed size
+ * sub-groups, with @propname from the device firmware description and
+ * stores them to @val if found.
+ *
+ * Return: Number of values read
+ *	   %0 if the property was not found,
+ *	   %-EINVAL if given arguments are not valid,
+ *	   %-ENODATA if the property does not have a value,
+ *	   %-EPROTO if the property is not an array of numbers,
+ *	   %-EOVERFLOW if the size of the property is not as expected.
+ *	   %-ENXIO if no suitable firmware interface is present.
+ */
+int device_property_read_u32_2darray(struct device *dev, const char *propname,
+				     u32 *val, size_t nval, int multiple)
+{
+	int n, ret;
+
+	n = device_property_read_u32_array(dev, propname, NULL, 0);
+	if (n == -EINVAL) {
+		return 0;	/* missing, ignore */
+	} else if (n < 0) {
+		dev_warn(dev, "%s malformed (%d)\n", propname, n);
+		return n;
+	} else if ((n % multiple) != 0) {
+		dev_warn(dev, "%s not a multiple of %d entries\n",
+			 propname, multiple);
+		return -EOVERFLOW;
+	}
+
+	if (n > nval)
+		n = nval;
+
+	ret = device_property_read_u32_array(dev, propname, val, n);
+	if (ret < 0)
+		return ret;
+	else
+		return n;
+}
+EXPORT_SYMBOL_GPL(device_property_read_u32_2darray);
+
+/**
  * device_property_read_u64_array - return a u64 array property of a device
  * @dev: Device to get the property of
  * @propname: Name of the property
diff --git a/include/linux/property.h b/include/linux/property.h
index a29369c89e6ef..854867f0d139f 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -43,6 +43,8 @@ int device_property_read_u16_array(struct device *dev, const char *propname,
 				   u16 *val, size_t nval);
 int device_property_read_u32_array(struct device *dev, const char *propname,
 				   u32 *val, size_t nval);
+int device_property_read_u32_2darray(struct device *dev, const char *propname,
+				   u32 *val, size_t nval, int multiple);
 int device_property_read_u64_array(struct device *dev, const char *propname,
 				   u64 *val, size_t nval);
 int device_property_read_string_array(struct device *dev, const char *propname,
-- 
2.11.0

