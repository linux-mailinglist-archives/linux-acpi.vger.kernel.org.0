Return-Path: <linux-acpi+bounces-18327-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6D1C1A72D
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 13:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 304D94F9422
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 12:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2B93451C9;
	Wed, 29 Oct 2025 12:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bhGyUaCa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FF537A3DF
	for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 12:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740934; cv=none; b=aKM3L3gvf2jB12zCiuv7OnSJw3IX5BLq3/uber3oN4Z+ebKM4BFMejnJGVIwOq4Tw6khUY3o4TR2GiEJ+YaY8einGR1vsH2lU2lDEhySjj0lRv59E1LJNk2K8UxDYtH5iowSBmprBX40OFpixw2sV6E/28bcClgqqTNNGQxc8dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740934; c=relaxed/simple;
	bh=skajDdkx5Zlz29MD/hcb1hp9VY6nNzXDfPCVk14jKnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OT+a26gr6IuySd9EdwTqLX4oOLBx+o8QkTq1QrzS1zGLpUIvAOQogw2dTxjvuKZ9HIfvhK4orVeLCYwoYFGXlcIaMCX+Xk7yCkW77owHVGGy8YNCXyq/pQzpZXBekyoP4qRwRcSFoWEtFJuZNOY0GMfEFpx/8K8mAgS7m165ufo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=bhGyUaCa; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4770e7062b5so27798335e9.2
        for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 05:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761740930; x=1762345730; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ADoOM/VSdH1svjCmremSeFtxhsEEw1L9u9ya69bdw08=;
        b=bhGyUaCaORuWVfs5DVPcbvoXApWKo8dIPj5MxCpDhIektHQyrYReZujhjLopLp3Afg
         wRQT/VILxWqpPKe/AkqL78SwfBKssLaTJCLEbrA10u5y9oY07EpgI/0zta3DnOb2g1Pf
         D4f+ogi4p6aqm/qynSTh6lK5OcTsgeDQkYPyhmN1bsP8CTKnhvUQdLXwWLgzh4gjnfza
         ejGOIll3YQIvi8oGqlSVUNKrvbk0XFu2zkwbHHzZNu47iu059X6Mxu5rBMNHp5aF7u2/
         Q6DpGfHiPspeKj67rA4iDSSabsQlmhdCBPYczTfgne51aaEIV01hc8gNhgyDtctB6CK9
         9PvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761740930; x=1762345730;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADoOM/VSdH1svjCmremSeFtxhsEEw1L9u9ya69bdw08=;
        b=k9sV4lfnIpw1PQj70xVzY1jRJIAK4ECWB22txRCpZDTl3UFgWapQ1knhUaptmj47Fz
         rwxgKAnexQoCxxseK8gz1aFbV4QWQbwIQZurwUBHSE/N/4HRSyZufNdqA1ou3vE2L7Wd
         TKiGEIaPAkKHRSzyXCzi3WqmURANESw8aVngiqN+FvS5ThKSmf7cKiYzC0CeFCpG1oNt
         kJ6+BsT/UionX/Q1Ar1EH2KQggMzQ6Ir2v6Je6ULiavg7ncMH6JNwFiJIHdfbz0+UOJL
         J4CN8iUbijBYzF4PktoJ/enplAYaH20hASnL3UhODN4vcu5SCn6IATa18INp8YToNhiO
         utPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRSMoXuBiJUHqBk71obs60euQ881wbAeFH9l2SOF2tSkz1vvLKL6hxD8eBBBzKaFokbWgRKw7e7Czh@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0z39dzhrgSL3y0qErozHdCzeUqqIQNJXllpd/MeAoQgiD0BiR
	qDRmR5P8BOeMkrQAMh7zFnFm6yP2ekQ6J8X5nKj266cTJNAnaZZgGmeiVdS8uKwVS+k=
X-Gm-Gg: ASbGncuLWbTwY/UOYsy3DRqMC9qKfuHP9JhMDHRAAMsyjdSI4T+OM3M2XyEM2g6l25T
	BNcAyjt1w5GbKR9lCvjgN+2qmpQhWQfnHTimXDvfZoH1xcfZ0dBCvVPOEtiplSwFzi6/D7MTXyW
	+L2zdCSe6HPbd9kC5XhRIip/cBAWqjXnPC60BjA/L5RVnpXVU1SN8E47PadxvLmHkqYGr2FA9ap
	GgfDPAboDslgN5FO5qFYzz4ENiq9g6Ao+KQQDGbAvAGNSJIY1i26CMasB2IYpNMFKG+9dxlbuTT
	XeOv9l4JhJMv4NvYAGS5bMlgN0QTTDhKo/1uhCFBekSDdQtSayPIWKRcvOS+j+jKc1vuJQxTU8v
	ULE9MAcOuViiPlOhwj+Kt3f9xo5vU+rlMvhKSIl7gE/nfAVWqrL3Vds0hugsDTqjfSq0fTFQLoQ
	rZzLJu
X-Google-Smtp-Source: AGHT+IEnJ+WhxDkZIJ9MuK8VVXfeLR7pgxX7wrR3Cm/oHex4VAz3yq0JAGJ++1/P5p09YcF3eLjcTA==
X-Received: by 2002:a05:600c:19c7:b0:471:1c48:7c5d with SMTP id 5b1f17b1804b1-4771e166d82mr26066235e9.5.1761740930278;
        Wed, 29 Oct 2025 05:28:50 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:69f2:5f2d:9ffc:a805])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e3a88fdsm52775545e9.10.2025.10.29.05.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 05:28:49 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 29 Oct 2025 13:28:35 +0100
Subject: [PATCH v3 01/10] software node: read the reference args via the
 fwnode API
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-reset-gpios-swnodes-v3-1-638a4cb33201@linaro.org>
References: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
In-Reply-To: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1039;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=Y2y5LmjezurCeJ0tOGGS7EN2B+Sg4Y820lPpRdnBzxA=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpAgh987Ua61Y0IHc7j94O0sWWeNpeijiq+Xbgr
 wfDwuVD52mJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQIIfQAKCRARpy6gFHHX
 ckbxD/oCf8GthQZQ7GAyEqL3Cp8rHV9kzEeP4bRMf8hbbWQ6crNOn6AD90eeOPQWrjJV7Cw/5TN
 6W/V9WR8drBRKWdVPi/MR225bdzh/5XiB+cbd0MD9EYti+ZHnVhNl7oZCo6znnSbUWrH/F/NrUg
 N9/vhAGqBKNyRuMHx6j6glju3nIPjQlkUzhsBKGVwg1ck/YjLvJDTM9Nfc3U5qgw0nCDrUSKb1Z
 TEGVRUn/Iil95LGOOXxiyH8gphD8shbuWaJ6NIzw3AsV7+uv+cRcU/g/wjHz7hoG4QrjvAAEqU+
 BVO3hupD1T839IPqvH1iI5kop44Un/GSXbWjBPsNKjAEeWD2rODIUwPi9GXB/swy1vD9BZeHKWw
 DDrWgyJPqB+AbqY2USCKuWnK6oY1zzC8+Jp5GzzdTvqtbF5lbS/hyyK5RMeg2+nmte40ZALoWQy
 CcEUp++VF/hcAYBcAB8eHy/BT4+CxFTDvHHHRhXGlza20bvOWtoYMhIKkqUQdRKFc82C+gWLqTv
 U0BlsplZ4fMLCorbOw1ga9RMutjTqa3HgMXMyDlPtqh1XUuNuTBmun/zJ0/SY3nc52JHjUeyk+8
 I4vTIPgV5FVTtP/CVYlNdlo0Qak5FRjLQSj4nPcmp7JW2sHwVddmGCbyTKd2uQPpXEoy01izuxW
 ipgFJ6rqkUTNsrw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Once we allow software nodes to reference all kinds of firmware nodes,
the refnode here will no longer necessarily be a software node so read
its proprties going through its fwnode implementation.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/base/swnode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index be1e9e61a7bf4d1301a3e109628517cfd9214704..2994efaf1d5d74c82df70e7df8bddf61ba0bfd41 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -540,9 +540,8 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 		return -ENOENT;
 
 	if (nargs_prop) {
-		error = property_entry_read_int_array(ref->node->properties,
-						      nargs_prop, sizeof(u32),
-						      &nargs_prop_val, 1);
+		error = fwnode_property_read_u32(refnode, nargs_prop,
+						 &nargs_prop_val);
 		if (error)
 			return error;
 

-- 
2.48.1


