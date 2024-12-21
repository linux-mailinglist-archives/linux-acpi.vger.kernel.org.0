Return-Path: <linux-acpi+bounces-10243-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B2A9F9EF9
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Dec 2024 08:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB12F1887123
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Dec 2024 07:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D321EC4DA;
	Sat, 21 Dec 2024 07:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsNuE1aC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617051E9B32;
	Sat, 21 Dec 2024 07:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734764981; cv=none; b=thC0adLuFiFEI+Gl9HXJDSmzTz7+/4hnhMcj9j9azF8cR4Cj2573SP4HpqKFeH8RDEVsL0Oz/4RbNB+Yvw2LrNIZr1D/8NehdK3BrTSg4YG2xM35b7+CU74WGeDvYAOtJPo3U8FNqTSHu8M9yp7TiG00SMXdIIt2/XLtBh8mNv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734764981; c=relaxed/simple;
	bh=xok20/shwIlyFfUKXvr7/nxW6Uk8F6oqDmmoEXD5si4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P8Np+mF2iSGmFSwzRucH8iEMG3k0U7j9RYFUo6/SQocD0ah/oKC2rEGElkqKqXylZu29FpwG8iQMkc4fpu7EdNmURNxpqlDACkX729CPE5HrObMobIGn28o5OTsJLz8M0jlKqmQ/gmrRe/A3xFXsmhg/8FjpJA2EPrTXlCWJb7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsNuE1aC; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e46ebe19368so1973572276.0;
        Fri, 20 Dec 2024 23:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734764979; x=1735369779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6swryw7eEVEAx/tXX3Xhx413mPXTzQqpDVNNvnPaYnM=;
        b=VsNuE1aChXKA/XiKRSMVzg3g7E1sTbdDvAggz+AoyISwNs2WyzOE0hIAEUcdXTh3MF
         9bSeQsm033ipVHRE+l0Hk+9z5FlKneBhw5hhfYH5ZTWJCB5kZq5yz1iZT3wUaXA4RGlg
         nwt+nkPgTh1aP/rAlWep8AKiSVRTF+VNBs1DYEZBbumapzASBh8ArhWIPWOiCHaRmQmV
         wnVnOOPeyiqGaEGfYVSphfj9rwlBNZTs2dhA2Em9lE9sLhQkQi99d/Qg/Ms/sJiYVWAM
         yhqt11acO7ghX/uTBD3aE2dlh8U1UykSeg5CKISBcluFte/NfrnbBZUnNdTYSMHCBS1c
         3XIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734764979; x=1735369779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6swryw7eEVEAx/tXX3Xhx413mPXTzQqpDVNNvnPaYnM=;
        b=aaQBSKTsdOhwZXBwQmhkRFOHX6Hww+Y9XZPLzSB/uRP4hXVVzsxkw0Ww2pdAz4C7Gl
         RT+sX4F6IaMv54tF9OAJFxpPIXWR+Z7X9AFwzpVdKK1KlQ5M3v25PghnGyGpuZtwO3mG
         iU2BxLfSxQlHOKUfNPt0ISb51viD5L5cbYtrK/Ryue+Y2gPRlkwv+jytwhXkpKeO96ZL
         6VItOVrMnFpBDU8fX3FE9h+nCGyuevlRCmGlkFAsDd583cKImzl9qy1uLLS/197mksCe
         uXO2UBaf4KC04s0Hj1ntIKkKnGqjxN64J+Y92tfJA0Dl8Sx3dQbviTlpCxa+jbLK1wTH
         0+9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOJvaFx9wI2kUcOW/cdwkrE5OhJcTFMtmEQ5RME1xYLr1etZ2h1Sp4nZWMJNYEXqN0a/xYA9mqvRsPwnXQ@vger.kernel.org, AJvYcCXb7/3/5MRwxTqLvoHVK5WElZ5Qn1KWISpiFnqArtAwzYzaMT4VGpJXAR64PhPILmMi5bLvZIz6mrHS@vger.kernel.org
X-Gm-Message-State: AOJu0YzGm+hJzvHD/OdERBCu3Tw+8r2EephU2Hnl2rWwvdtQycWsKbQ5
	znK64znX3zo+4I7Px4Yup9ORGTY+q+8+CxapXZ1D41BTHcbyGfNq9DFGTw==
X-Gm-Gg: ASbGncvXPplKLPdXHYVl4B9iNlgjIJPxr5TNFAC3uaqd2j8/sqWqMHufN5BO/G6rtKC
	VRrKf6EOhKL0FFtLWpfmmMIf54mdYNPVCXUcVyvXaZokbyeF5NgzYQDcxIikcrpJKesK8fTTJgT
	bmC1oRdaHmmguipC2KyzBUp5mpy6hlZHNRlWQFHbQw6toythnUMTFiGk2eVi2PwA0ues8q8Ra0I
	4a90VERcWca4fwkojKa4oP7t4O57/jHzVaL2zT9Bujeis4I227+zgsegqLvnbrn
X-Google-Smtp-Source: AGHT+IFgbMzcAcMzcnjgTO1GN0CDUU2IrttLGoKFZM2+f6lhgvIyhvDnYSHdlvC3CR3/+HPYYhEUMg==
X-Received: by 2002:a05:690c:5b41:b0:6ef:7f89:d8fa with SMTP id 00721157ae682-6f3f8216c0fmr30312657b3.32.1734764979038;
        Fri, 20 Dec 2024 23:09:39 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f3e7498215sm12367977b3.60.2024.12.20.23.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 23:09:38 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Hans de Goede <hdegoede@redhat.com>,
	Gergo Koteles <soyer@irl.hu>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH 2/2] alienware-wmi: Use devm_platform_profile_register()
Date: Sat, 21 Dec 2024 02:08:19 -0500
Message-ID: <20241221070817.3764-5-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241221070817.3764-2-kuurtb@gmail.com>
References: <20241221070817.3764-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace platform_profile_register() with it's device managed version.
Drop remove_thermal_profile() because it's no longer needed.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index e95d22c7b60c..7b3ee2d6a23d 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -1159,13 +1159,7 @@ static int create_thermal_profile(struct platform_device *platform_device)
 	pp_handler.name = "alienware-wmi";
 	pp_handler.dev = &platform_device->dev;
 
-	return platform_profile_register(&pp_handler);
-}
-
-static void remove_thermal_profile(void)
-{
-	if (quirks->thermal)
-		platform_profile_remove(&pp_handler);
+	return devm_platform_profile_register(&pp_handler);
 }
 
 static int __init alienware_wmi_init(void)
@@ -1239,7 +1233,6 @@ static int __init alienware_wmi_init(void)
 
 fail_prep_zones:
 	alienware_zone_exit(platform_device);
-	remove_thermal_profile();
 fail_prep_thermal_profile:
 fail_prep_deepsleep:
 fail_prep_amplifier:
@@ -1260,7 +1253,6 @@ static void __exit alienware_wmi_exit(void)
 	if (platform_device) {
 		alienware_zone_exit(platform_device);
 		remove_hdmi(platform_device);
-		remove_thermal_profile();
 		platform_device_unregister(platform_device);
 		platform_driver_unregister(&platform_driver);
 	}
-- 
2.47.1


