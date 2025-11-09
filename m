Return-Path: <linux-acpi+bounces-18695-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11314C44192
	for <lists+linux-acpi@lfdr.de>; Sun, 09 Nov 2025 16:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37BC3B1502
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Nov 2025 15:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40652FDC47;
	Sun,  9 Nov 2025 15:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mWpO+C6O";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PJXNhCv3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05CD2FB61C
	for <linux-acpi@vger.kernel.org>; Sun,  9 Nov 2025 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762703625; cv=none; b=A2KTxMzwdw+dOjBVe7BxbT51qYP48Z+0Hn0Kn3wtLfqJ7s4utURdeoPcXwQmdbKW4dDptFt3XUGx2d7Sd62DiStxHpUr5MPnqlmolP5NsC8gcvBn1YHOaoel0vPAE88zyXZbw5xPs5EcUDS0ZVDcv2/z7m2gviKojH1KB7TjOTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762703625; c=relaxed/simple;
	bh=KQnezTdDom0hsWENXoHj5Ie0hLWZqEuMHNiHb/oWtCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=guGCWTad9h0rsdBHPUWWl1QgEwPd8Z35h3Oo7nsxl0pRh5gTFRbMtgV0D15InPwReBktNj7IFfx/fec1sX3FRjdQkvn9d7uUUmnKTeJqzIhz5vSh+33cotx1tYsJr02nA1vfaihWPS6msnkUmdtSF0bNYlXv+Q2cGkL35plt2NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mWpO+C6O; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PJXNhCv3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A96csNw034841
	for <linux-acpi@vger.kernel.org>; Sun, 9 Nov 2025 15:53:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ad5t/trqWzBhM8TQYF+OEfs7U4Sg5TTK3ZP
	9EeDm70g=; b=mWpO+C6ODxREI/Ja7/UhHiKkTn4Jtvs+lGySbj6708Uy5iEsEQ8
	+45MS1uyqyus7Pev7Dc4Q/x4NL73cqJmQCwPmQwmvjN7txYgI0Fi9FOluTWjW+k7
	OfJ1jSkiOvWpJ8+9qFQULfDusiAA5PHQ7xDRZFMI8JXOx7xfgfDHvCO1ilzvmZBy
	T75HxJ94BVtajWNS6LMrM8yxrA3YVoNjNihbP9StjmqBvsTyygJEKrrBzF9lHtcj
	2FzS7Gk61xsaSsZl+vnEUhGIgiA3pmPckU07/M01HSfwSHpAUhdUVApiUVWHZxXF
	y3tLMQpZWnbOGC4BkOtYBZq2ZufGbCsmsTA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xwfjb5f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Sun, 09 Nov 2025 15:53:42 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e8b33c1d8eso68191101cf.2
        for <linux-acpi@vger.kernel.org>; Sun, 09 Nov 2025 07:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762703622; x=1763308422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ad5t/trqWzBhM8TQYF+OEfs7U4Sg5TTK3ZP9EeDm70g=;
        b=PJXNhCv3SEqoDS6dEOWS51zN7LvC0UaOGZspduZU+MKZWPGs5Huuywbo6SgvRIyKH1
         W1sFG1c+JOu9n5yZkzl6eL6XroAButfSnFTmUiknm7NN2eWAHaFeuVoNrCgr1HyFMjQp
         HZ2n7NYYBz8GAxK4KuZTb1wk+go0VpPH1GHOtleVEyVYQPQ2hkHawZPyoz+35I8eSTYn
         YR9hy9vGSAIjgasQPJsJW8hI06zQRJCtzyaYSAOQs70jBuLBaSygyOuDNCdjt0igkDUA
         tbEu/JgtC5m85Nu9P/5xfveZJuX//Xis6qWuJ3EjO79X01O0hu78nNv3WDyy6uARt2Xg
         OLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762703622; x=1763308422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ad5t/trqWzBhM8TQYF+OEfs7U4Sg5TTK3ZP9EeDm70g=;
        b=wFHSoKRvIwYeUqtBK+l7mCeCA03IFSJfXQ1RpdTmNWJMS7LNGpHGAFGOl6xt0+b99+
         OxTKapyUXhaa7GsXIB48TqPn9Sc1oqfpPCJd8+TjwA/hJgP8WCZ1SaasUjveoJnHlbgM
         DtDM+wM6cjK2cX5HqGwO38v933ov3niUQ/iPf7J9jiOKqfoLu03/6QfQRO9RkVkGRMLq
         7qaaBxpT/dCdVCDV43gMhTSsaD+5VXYZJx9B7OMG5UfXIHlldnRftT3Lb8W+BVxhMROo
         4HOTcHQXl0xwBSgEKgUF42A/qjQcZ/ZKfE/TAkIQSQhPKf0VsornT/vcB5c4Jf5BnrJQ
         w1oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgq4yEF7JMDC0lJUrciEFdyMiOokWj8QGoVFsZglc5RTAeO4qh+X4bXbxJuHl2KtZcloYiDUPlS5rn@vger.kernel.org
X-Gm-Message-State: AOJu0YxcuGjXu0y8T5CalKuKVzsXAY8eEN3KJGJvZ9VbBbAJ/F8K4tuj
	9n2vIzug4EOJkE+jrULbWvtL68VUZbKxB+4mCPC5izrOcnKJ+7oj+syImdMULLfRphJDGUL2MUd
	B7q9I7Fi75Yt+Wj3fmxMgdwuN+7dIS4iNo/gqIg3Iv+Rox3Iq+xu4M40OZZFmstSJ
X-Gm-Gg: ASbGncsmnBx3uj8ROIqAvCTyzKDc8rQf7tn0tZt2zOu5qBFCN53pScUl21HZ1x8PdcS
	ZDPrptGYFQXlTzJROH9LGT+oJUMyx1hDeHKDfkDMrmdNWIzLz6Gm9ZmYUybJxnz9C2Vq4oDCm1r
	KqmzU9/r6nwOzxY/epQgHn1GBCB6qJR+njgGpaSS2I2V1Pi6bAym8piMxhPBJVJ/KBSnbyYKY9n
	J+i+a/mestZ1U0Ot7RwoU4ZsX3WS7lYvCbZlaF6ipu8vZb+LUYyHybkWY9cUIMx1MIHIM8a8fET
	JKUDtWmKniChtWy9FqzyFg9hHSSvkWaCwnG7yR/xZy7nh+kj3hWw0aj29DX7sekr0gYW3AZgv3P
	DpSOTijuclH5GY4NcBZaerY7um+bqPTuiIJL7sCW8uK1QyRQbUmyIOi7peI3HDHCDsVRGbt84Mh
	JVDe8c5rU4LpA+Pg==
X-Received: by 2002:ac8:598b:0:b0:4ec:f1a4:5511 with SMTP id d75a77b69052e-4eda4fc3b6amr64345091cf.65.1762703622162;
        Sun, 09 Nov 2025 07:53:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8TVYNMH9gjdSp4eih1C2sC7MPmmTtAovB2I0o9oJc5rZmDsiTsFIUZfhO6uKj8LvMxca1Jg==
X-Received: by 2002:ac8:598b:0:b0:4ec:f1a4:5511 with SMTP id d75a77b69052e-4eda4fc3b6amr64344851cf.65.1762703621703;
        Sun, 09 Nov 2025 07:53:41 -0800 (PST)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf9bd72bsm830838366b.49.2025.11.09.07.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 07:53:41 -0800 (PST)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>, linux-spi@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH] spi: Add TODO comment about ACPI GPIO setup
Date: Sun,  9 Nov 2025 16:53:39 +0100
Message-ID: <20251109155340.26199-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: h2UdSUbpUSK_ClkktpLdQHxZ6x4rd9OH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA5MDEzOSBTYWx0ZWRfX3VZrHMi47DY3
 akKRBzz9RnDs4cD7EzoSx+eN+erDrrrNLAgCdxNeVFnUE/GRgnJ6ZEjYYsVJnVL0N++Qiur+Dul
 w1Se8zbyIPvriFGj+dkxq/fDDxGMPO9+4mzVRNHU50OsxIhGBvaQtWHIkln3Ml0IB1eGmVDZImL
 lO4IC+/gfQmxxALwsV4rF855hDOYolm+1SJroJkpjm8jXj1ozj2qoGeZgYKyWs0Xn+w+c7x2YYx
 rpxpYtJb/cDBDpFolMfTCYFmTr1BubkSnZuiXDLc338EUUmImSc+S8UEvPYREGSWCNmDpCCC0QG
 9kN/eW8UJq+F6eYIm3Tvx9EiWtrhk6bTXRsUpxtO7HrCqYAPh1TtUC4Ed8JxyuaL63iP4g1RD63
 sgE9+rS4Dw0Oh3sNOWjZhS42XdoQGQ==
X-Authority-Analysis: v=2.4 cv=LaoxKzfi c=1 sm=1 tr=0 ts=6910b906 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=_g9i7aCbpyJZyCEgokwA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: h2UdSUbpUSK_ClkktpLdQHxZ6x4rd9OH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-09_06,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511090139

Add a TODO comment that ideally the ACPI/gpiolib core code should take care
of setting GPIO direction and/or bias according to ACPI GPIO resources.

If this TODO gets implemented then the acpi_dev_gpio_irq_get() call in
acpi_register_spi_device() can be dropped.

Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/spi/spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8588e8562220..e25df9990f82 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2857,6 +2857,8 @@ static acpi_status acpi_register_spi_device(struct spi_controller *ctlr,
 	 * here too, because this call sets the GPIO direction and/or bias.
 	 * Setting these needs to be done even if there is no driver, in which
 	 * case spi_probe() will never get called.
+	 * TODO: ideally the setup of the GPIO should be handled in a generic
+	 * manner in the ACPI/gpiolib core code.
 	 */
 	if (spi->irq < 0)
 		spi->irq = acpi_dev_gpio_irq_get(adev, 0);
-- 
2.51.1


