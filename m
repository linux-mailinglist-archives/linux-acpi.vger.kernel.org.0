Return-Path: <linux-acpi+bounces-4492-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E0888D7E1
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Mar 2024 08:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 217F71F29FDE
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Mar 2024 07:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C597F5576C;
	Wed, 27 Mar 2024 07:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qTd1u+qy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE25C54FA4
	for <linux-acpi@vger.kernel.org>; Wed, 27 Mar 2024 07:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711525544; cv=none; b=uJpY+EsSkincYrptumyp2zVppfzNuogNMST+bg15Lc7DwIUWvEFvgMcp+RSpOLrRDwqSnqvmRGuRlFp9+663FwUS8znTaQ290hUb/lFS66hmOOA0hsX6OP6VEmbKpe6OD5cP32qPW2AzYfTHxi2XTIMsv5/Ay4H+yoahfeQkV0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711525544; c=relaxed/simple;
	bh=zmZtU0HeWjnhb8rTb7HsDmqwgy0dY3Ru/yp2oFw0vc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qCjyx3yzSMQws6x42CbEe7ZTqXwS8c1sWfqSWcI2iCb91bdFjl/EUkeb/2dxnB6Jnqk2yc6guRUXxNEYbktx+dGkkHauNKiM4AtNRvWLk8O+Gfjno8C6J5I77xG6fIoSJOcg+ozWxNtOuIrpNwwBaT6CukjwLWp2bgrPebjX4c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qTd1u+qy; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a466e53f8c0so837571566b.1
        for <linux-acpi@vger.kernel.org>; Wed, 27 Mar 2024 00:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711525541; x=1712130341; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f+WYRd4bqW+edM8CrIjAxbZSq1G2Gx3+9SVB8PeonXY=;
        b=qTd1u+qyWnKwK0X0jIH0UMI5q0gxTDsUe+tmxt96x0kGX+ZJzPicSxu7/wP5c5d/61
         xW81TVIab9GRJU2MDfuQpRF6SykLgZOcjOUNEYwGytsc/lVNwrbsNSwLf+XgLfhNdFCU
         xA7f9vn1XmSCdiAHjVvFopWiq8TcxEyzuL5aWsiCpG1SQIsDosb3WSxIn8F9R/Bb/XA8
         MyPbDMcAroQFfoHfX+geJalhtc90AoBqYTbROK9xAc4YYHBQc+KZe1Bu5a05aiVTGuqe
         8Vd29vpbqgXSgPtijTCepu9YiAaMlvlaaj64aWsaioUvJdodqBKnfWuYzj6jRBKmbU++
         mtSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711525541; x=1712130341;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+WYRd4bqW+edM8CrIjAxbZSq1G2Gx3+9SVB8PeonXY=;
        b=DvQt1m7jar639Zjswbiee7rYqtsXBJeIb8HeEgTJV1eYWELayRvQ0XqXihx7Sc+Efz
         6AiWqt3Q99bGN4ZuEm8X+sNx3nJ+mcl9PAXa77kF1ABp7dYLMJ5nH8usG6ztHjWbXKxT
         S+sl/mf2U4kn/WtcmkPRDkKFNv4o0XvzGThp92lVrPeslVjQNW2ZtwRksinnzMNY2vEf
         OOQ8YKNp98NxfXb9v1nhdB5+dNYVxeKvWakJihGBOpR3As2H6bGI39OOdvZyCGe+LLSk
         aJWUHMgrw+WWWAGcBH9hMzBR2xA8a3yKsrnlK8B6p9HvdMFIpUJrlEt2PMFCVFxcOzo3
         Z11Q==
X-Gm-Message-State: AOJu0YycRz1XPv+6n4wXoqjA3V9i78IvnyIJNMVRlqQ1LT8HiYoA0jiu
	ajQCPurNN2wzERsIxDA/5CIiBDuGvRQCabkwNQN1q+VJdMlxbsQvuaUZ/eu4Eqs=
X-Google-Smtp-Source: AGHT+IGXfcgsgzzWHZVcAiy49v9e1YW76j7MtXwd3NdpkF/Ed2e/YY91Tg4og9yNKx7cY82ojJLe0g==
X-Received: by 2002:a17:906:28c7:b0:a46:e377:1468 with SMTP id p7-20020a17090628c700b00a46e3771468mr325218ejd.31.1711525541309;
        Wed, 27 Mar 2024 00:45:41 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id am11-20020a170906568b00b00a474690a946sm4671745ejc.48.2024.03.27.00.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 00:45:40 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 08:44:03 +0100
Subject: [PATCH 16/19] platform/x86/wireless-hotkey: drop owner assignment
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-b4-module-owner-acpi-v1-16-725241a2d224@linaro.org>
References: <20240327-b4-module-owner-acpi-v1-0-725241a2d224@linaro.org>
In-Reply-To: <20240327-b4-module-owner-acpi-v1-0-725241a2d224@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Corentin Chary <corentin.chary@gmail.com>, 
 "Luke D. Jones" <luke@ljones.dev>, Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, 
 Daniel Oliveira Nascimento <don@syst.com.br>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Matan Ziv-Av <matan@svgalib.org>, Mattia Dongili <malattia@linux.it>, 
 Azael Avalos <coproscefalo@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>, Jeff Sipek <jsipek@vmware.com>, 
 Ajay Kaher <akaher@vmware.com>, Alexey Makhalov <amakhalov@vmware.com>, 
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, 
 Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 acpica-devel@lists.linux.dev, linux-input@vger.kernel.org, 
 netdev@vger.kernel.org, chrome-platform@lists.linux.dev, 
 platform-driver-x86@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=687;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=zmZtU0HeWjnhb8rTb7HsDmqwgy0dY3Ru/yp2oFw0vc4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmA85YeWyG9aebJKVthjZRE4coVLba6TAgegH3K
 PXphFi7JpiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgPOWAAKCRDBN2bmhouD
 158WEACSW27Lsavj/WdnCF+TQTg9XJ93cSTnyScKMm2EaHorzIaeBiWcl3TGMPfMHwqNFyLrXoO
 QYdySKLvhLLiluPHZ/oV5PZ4ESiYGi1e6/wTM1wXzTr69WfKtAWSUBMCb9CJkq0DmhGRWCp2Fvd
 t5NdW6zYBTzO5SN3yqiSO7YURo5XqM83nfQThz9xB21/rUInIz/pcaRwtWFctsFTRJD94JUnZHE
 kIckYQlikDE/rDqChjOed5Vfs6+S+PNgOiOyvoI1ICNaLlqz7n1oZo90z0TfJTpP6wUCACi+1TN
 BUozrcZM+f4wX4zGHWaY0qHEnA2hTMP+chBq3zMqEN4m0DEfDnP+QGhgqrUWNwu95xJ56A1jDzY
 b+30FODq6umCcGOPSV97JtYJFW1etUduNDAwysFTb5m1r080mYDDJxk2QxA/zrFgOagHE6GNpXu
 c++RHRfekLIQii23YvmYBqigwlEGUXm1GylgJ6S91tJCBQhHVSo1wejY+18Hr5h4FJ+sV6rjF6a
 kF7B2fDqg/6kRx2D8PVYnlBUe34YsKA4YK9nTZjc7SCyqRUPPxca7s0oatWzqNRSo0YdyaF0AjS
 08Xr4uoZyMVpGONKplUT0TyEIc3hGeyvkcItrWS0fvrMNx4QnfwQ7WQtg2pdU039eFEZcey3pv3
 TDW+9WvSTH6VSdw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

ACPI bus core already sets the .owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/platform/x86/wireless-hotkey.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/wireless-hotkey.c b/drivers/platform/x86/wireless-hotkey.c
index 4422863f47bb..e95cdbbfb708 100644
--- a/drivers/platform/x86/wireless-hotkey.c
+++ b/drivers/platform/x86/wireless-hotkey.c
@@ -110,7 +110,6 @@ static void wl_remove(struct acpi_device *device)
 
 static struct acpi_driver wl_driver = {
 	.name	= "wireless-hotkey",
-	.owner	= THIS_MODULE,
 	.ids	= wl_ids,
 	.ops	= {
 		.add	= wl_add,

-- 
2.34.1


