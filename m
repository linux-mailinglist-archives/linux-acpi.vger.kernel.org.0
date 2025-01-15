Return-Path: <linux-acpi+bounces-10661-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE1CA11AA6
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 08:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7504A3A2E35
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 07:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D362361CD;
	Wed, 15 Jan 2025 07:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaDUg+Lh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E534822F388;
	Wed, 15 Jan 2025 07:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736925172; cv=none; b=bJbf0nyd7EQ+CE2T9Ka6xdtw3yNI9lRO6mQmNGd9/Jxrdd6zKlwD1a6mOAmKXp2fmGqCnZr+Ki7Fn/5o+lznAQChYEojhzWVcGsUHol1nHJGuIa8F2j5HkAoQwoGZZCAgmXhfIF9rtn5e03jPJSM6k0kvV21xrKIfafBqZ+0XP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736925172; c=relaxed/simple;
	bh=jpIOJ2WQ3LP4s2VyPamcYNiT/HAo/fgENm0150i2hh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aiVVkbtdZ2eiXBv5u/R0foE2W6VNrAbIAg6tJAZ47agHM+5MSN9B4zGtbzE7KMaMbyc+5UdWXDZ8E4SnyMBgxG1TZcp/FvC1hbXEuF4t5fkDBiVni5dpO8y0uqOok0aEykYpMOo9GsK5n+XzIpy6/rtHRst3qXC2AUoH2ql9pbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QaDUg+Lh; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4b6398d477fso917413137.0;
        Tue, 14 Jan 2025 23:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736925169; x=1737529969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Bslg8YPubVdyuYVrXhPddxIABzDcDevDQwcDkILavI=;
        b=QaDUg+LhAtrQS4dmueLLX93ANcBjnR0TEMhhVsUjtldwSgtJgUjH5mz9uwQ3ci1qyp
         ZvanmVUUIPE1iVv2IF7IsmZfX6Fxcc3aHLiOFgR1IdLUuHcHT7AmwwmHpTM3PJHMRgBg
         FO86H6ckm2i+HgwTAfNm52diCHBllfQHjK8MEjSDuOSe4EDpduJR9VouDPoWFc5C4m/A
         gr6KC2W71fWU6fqd14mosv/7FzzOc5hnpy3FfBs4M5H/b6VZPa01/l9HYwZXlzg/nJtk
         hn13B3BArf47Z0ADE0ikYc9sCrB03NfEH2k379Gp6EhFDdnuA6gWyO2JeOsI38lEIEZ4
         ZuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736925169; x=1737529969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Bslg8YPubVdyuYVrXhPddxIABzDcDevDQwcDkILavI=;
        b=YoW+drtA7nTOTz/YD3shi/6J4mgoRcjTn8eZzHF7L8Zv9vNrVqlhdAzbjWWo9zwIuj
         RCreipVETsoiaEp+iZZuEQDOsoGJWYI2E9TAy8qcZkH2OmHOVwGHDQ6Y2GzrPEufyw7D
         eiJ7lFByJ0TG1o1M6c1GrjUNhJ5ElV5orapTpS18zb9KSdGJFctKG6aNx2M8KKjK8Aff
         6lwtNwxYhQszLEACbF51xuTyd/PCbcpzTPC1X7DnP3LQ35lHQLg5loX1yyFlfsfhe2af
         LrbKblioKugt5pXTvOBhwqV62Ct7xH48bRm0g0fmaD2ZL4RxWJOXxbUl3Pf+MdAE2SI3
         5uYw==
X-Forwarded-Encrypted: i=1; AJvYcCXbJQzMZqRQ6PLMkSYKK+XE6LULYnT0s2ZqZIV43vKBl5gzMrU+Yx+kT8rs72iow4kPHxkcD5x1TToPbZzk@vger.kernel.org, AJvYcCXlnP1akiREqQDP5V4cuxQI7WhkVFJegZQvSITXbnnKE9xOT4dwa8S05Fcs3ULd7PBqHfpmhZFb/pkk@vger.kernel.org
X-Gm-Message-State: AOJu0YzTkDzZWS44M2PdYxq/+HNvG6vK4wXydVXCvU5UBFEIw6a2ul55
	oT6a0PQG3BAAaejKsA3DtnqEWCj2lgCQVrdxuTnANx+hKcp+vReRaq1Kkg==
X-Gm-Gg: ASbGncthF8PIbGnPwoGZ6BOv7r3vA4eMt7Glx3D8+m9RJkjpyrHaIpFcz4NFtUhOipS
	An82AzmWX9Fcr7F68HzSeAt0jL8++WnyunOlzA+4dGPHGK9+JYCIODmFem42nAolfQhVxrsTwRl
	isiTi09MaGzyjgLPrLxXAF47BLNGFhCFtD8/6sQRWmvN+DGqZGYMXUXwrzpd+Dt8ydbV/tq1vh4
	GS+UttZZlYCmaiHmTCoCQCx99STK9ykROBj2N6Hb6uRveHgpsDaoqlN57KnoJLH
X-Google-Smtp-Source: AGHT+IHINVH7sPReywIOsggLGwidSB8frsJiyKoY9ksQdGcCIlrr0mlvQYT8NuHZJEy5eu0GCb3knA==
X-Received: by 2002:a05:6102:80a2:b0:4b1:1caf:f61b with SMTP id ada2fe7eead31-4b3d104867bmr26191206137.18.1736925169357;
        Tue, 14 Jan 2025 23:12:49 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f033ffsm5084366137.6.2025.01.14.23.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 23:12:48 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	"Len Brown" <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Mario Limonciello" <mario.limonciello@amd.com>,
	"Armin Wolf" <W_Armin@gmx.de>,
	"Joshua Grisham" <josh@joshuagrisham.com>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Hans de Goede" <hdegoede@redhat.com>,
	"Kurt Borja" <kuurtb@gmail.com>,
	"Maximilian Luz" <luzmaximilian@gmail.com>,
	"Lee, Chun-Yi" <jlee@suse.com>,
	"Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>,
	"Corentin Chary" <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	"Lyndon Sanche" <lsanche@lyndeno.ca>,
	"Ike Panhc" <ike.pan@canonical.com>,
	"Henrique de Moraes Holschuh" <hmh@hmh.eng.br>,
	"Mark Pearson" <mpearson-lenovo@squebb.ca>,
	"Alexis Belmonte" <alexbelm48@gmail.com>,
	"Ai Chao" <aichao@kylinos.cn>,
	"Gergo Koteles" <soyer@irl.hu>,
	Dell.Client.Kernel@dell.com,
	ibm-acpi-devel@lists.sourceforge.net
Subject: [PATCH v3 13/19] platform/x86: inspur_platform_profile: Use devm_platform_profile_register()
Date: Wed, 15 Jan 2025 02:10:16 -0500
Message-ID: <20250115071022.4815-14-kuurtb@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115071022.4815-1-kuurtb@gmail.com>
References: <20250115071022.4815-1-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace platform_profile_register() with it's device managed version.
While at it, pass inspur_wmi_priv to the class device as drvdata and
replace uses of container_of() with dev_get_drvdata().

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/inspur_platform_profile.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/platform/x86/inspur_platform_profile.c b/drivers/platform/x86/inspur_platform_profile.c
index 06df3aae9a56..e1631de6ad86 100644
--- a/drivers/platform/x86/inspur_platform_profile.c
+++ b/drivers/platform/x86/inspur_platform_profile.c
@@ -194,15 +194,7 @@ static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
 	priv->handler.dev = &wdev->dev;
 	priv->handler.ops = &inspur_platform_profile_ops;
 
-	return platform_profile_register(&priv->handler, priv);
-}
-
-static void inspur_wmi_remove(struct wmi_device *wdev)
-{
-	struct inspur_wmi_priv *priv;
-
-	priv = dev_get_drvdata(&wdev->dev);
-	platform_profile_remove(&priv->handler);
+	return devm_platform_profile_register(&priv->handler, priv);
 }
 
 static const struct wmi_device_id inspur_wmi_id_table[] = {
@@ -219,7 +211,6 @@ static struct wmi_driver inspur_wmi_driver = {
 	},
 	.id_table = inspur_wmi_id_table,
 	.probe = inspur_wmi_probe,
-	.remove = inspur_wmi_remove,
 	.no_singleton = true,
 };
 
-- 
2.48.0


