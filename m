Return-Path: <linux-acpi+bounces-10455-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D07DFA07B41
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 16:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E66A1882192
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 15:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C059C21D5BB;
	Thu,  9 Jan 2025 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPWDT8MM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E32215162;
	Thu,  9 Jan 2025 15:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435309; cv=none; b=oB/LqKRm/qgjFMiWXwhwRy3UVxpSz9LJCeuH5+/CywoxMq63e281g8fONTDtFb8qPfT98oAuZ2faz9VcMntp187JdYVB1LnLnIXd4rQ9Gmpk3O0wKVoKAWzlgGNYz+q88dj1uhsFZLeRs9H3w4H/yPVk7e8Mq3X8Ailwg0c7uXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435309; c=relaxed/simple;
	bh=KZeV286NRfqGS4NBEqA1eDQujyluseICOjJBryAdLCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvq4dfoCVguR+2EV1UgiKvlAVxu72jCUXx/HfTxVK3Xt0LD1bm5tnTV3MA8r1YCxknwKdCNIxKGSNTliSXWGfJul7eqDelngnnWGe0CJ7QoyQc9nHUeKr0WIvJRgVSuCAJwxeSVh+jV9sFQJR7tA0QY/14gAbw+OIlIfD537zC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPWDT8MM; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4b11a110e4eso286345137.1;
        Thu, 09 Jan 2025 07:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736435306; x=1737040106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1tUf+9DK9tMnD8L1mOJiRs8Bs/JKwc9KQrYpSk0By0=;
        b=TPWDT8MMrTPWRj4Gq3hnLg9u+Z8moFwI6UG1gGvxnvzB+urLpMeSO8OrUyIX8tyFY7
         7a5o+i2ZJ9urmtiHtDFa6SN+ykJGDpstfjjy2phBR+1tU5d8nlLWwEi45iKOjqbb7S/N
         jz0VHX53raLAX1RElvL11+yxafi6M9HODgRxJlf9h4CW7LtAHsnYdV4BTV8DMy+UDEpY
         8ZJyrlSOd2ep17JFw7ImsM8Wx3OmURhsqZdbACjOG/gecrPfUNAVESCHn7Y35Ra4Dpxw
         WC7RHwBos7lsE5xUv7FyJYeDZq98v9nbDGSKKut1Vixe/5QqGbxOGzkQ38QBJePls8fo
         1Ulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736435306; x=1737040106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1tUf+9DK9tMnD8L1mOJiRs8Bs/JKwc9KQrYpSk0By0=;
        b=agK31khi8ImJyBBvcHcnPIL1kjaxnBq8nw5AsDOEyIlnica45WLAKENNx3P7k1ZZ/8
         ul2Kq1Ns5pIGUueWh4+UYB5RDqevy8RryyNRiPOStxpRI6oP2qa9TNTHjAuh+Bc0KTFG
         QNnKFrPbaTxsA9rJ1MEskuefCDBOnMOpW+Rk+WMg57gOl4N/k+8yx9MD4X1cvDwa1HgA
         RehMQdBqDWHQ24sbPvs7tXDpdwKLOFFkU7FerR9h8sEmIE63tJKYNKXZSM5Moo3VCwQF
         rUaczrYG9ujfAbICuL58tWS09U6mmLib4HR4tR5khn+awPAe/TyfIm9b2umQQ8KJ5490
         E1rw==
X-Forwarded-Encrypted: i=1; AJvYcCVhrbouPr3NC/O0JNgiGVLzBHKyylo7k4jvSDkrulBe3jf9bpY2DyP4F1qeFUXzIu2eunUEjsWiDnhoseUY@vger.kernel.org, AJvYcCWFCcWtaTdNrc0Wn2f6rWLwsanVGeLqpWLeNbF3BQLSpbazXOzNrDbBA8Ag48vIyGKjlegyaROSJJP4@vger.kernel.org
X-Gm-Message-State: AOJu0YxS+GL6wsgjLS0iqbau4V2gWpE3XnOAnSIMkSgGA9jtXK/NoG0H
	gBNT4d9JoQFTL73cbxSp8VGTsJuQ5LTsLwW8E3jrqH1VxLAmgL6dQvrvWvgV
X-Gm-Gg: ASbGncs9leUMrrFHBxtRBibFxyNLAEs/XMHoiyd7X5DrYMX21RMEEx2Yhr799HKAPeo
	A72eFNd8PWGFWruJl62oYU+f2Sri/7DilawrP0+3hp2cbVhZOZGZypYVh47fdNrIRmaBLbEijsy
	5wyXT75DSo2p5UGSt8cPTm51EWK7IaMVQ0Jp+0ZxydyNTmp1ww01mozBcEpVPknkla5Ub3dHP4W
	5a5uRkgtbqpa1eDywjOoYyojTJDG6I6v51K/DVNIc+kCh3V6IbHhA0t6wIjHbr9
X-Google-Smtp-Source: AGHT+IFjJvB65qdIOtwWFZNJWYdGw8KSgBVvzhl03AdUSd1avMwi0YmqB1FWOP7JvW3yslCDCjL6kQ==
X-Received: by 2002:a05:6102:292b:b0:4b2:7446:fc18 with SMTP id ada2fe7eead31-4b3d0fb67bemr6267582137.17.1736435305836;
        Thu, 09 Jan 2025 07:08:25 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f4a5ddsm1019887137.11.2025.01.09.07.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 07:08:25 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Mario Limonciello" <mario.limonciello@amd.com>,
	"Armin Wolf" <W_Armin@gmx.de>,
	Joshua Grisham <josh@joshuagrisham.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Hans de Goede" <hdegoede@redhat.com>,
	Kurt Borja <kuurtb@gmail.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	"Lee, Chun-Yi" <jlee@suse.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Corentin Chary <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Lyndon Sanche <lsanche@lyndeno.ca>,
	Ike Panhc <ike.pan@canonical.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Colin Ian King <colin.i.king@gmail.com>,
	Alexis Belmonte <alexbelm48@gmail.com>,
	Ai Chao <aichao@kylinos.cn>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Gergo Koteles <soyer@irl.hu>,
	Dell.Client.Kernel@dell.com,
	ibm-acpi-devel@lists.sourceforge.net
Subject: [PATCH 06/18] platform/x86: acer-wmi: Use devm_platform_profile_register()
Date: Thu,  9 Jan 2025 10:06:19 -0500
Message-ID: <20250109150731.110799-7-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250109150731.110799-1-kuurtb@gmail.com>
References: <20250109150731.110799-1-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace platform_profile_register() with it's device managed version.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/acer-wmi.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 585d54d8d80c..70ec667e0cbf 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -1928,7 +1928,7 @@ static int acer_platform_profile_setup(struct platform_device *device)
 		platform_profile_handler.ops =
 			&acer_predator_v4_platform_profile_ops;
 
-		err = platform_profile_register(&platform_profile_handler, NULL);
+		err = devm_platform_profile_register(&platform_profile_handler, NULL);
 		if (err)
 			return err;
 
@@ -2575,8 +2575,6 @@ static int acer_platform_probe(struct platform_device *device)
 	return 0;
 
 error_hwmon:
-	if (platform_profile_support)
-		platform_profile_remove(&platform_profile_handler);
 error_platform_profile:
 	acer_rfkill_exit();
 error_rfkill:
@@ -2597,9 +2595,6 @@ static void acer_platform_remove(struct platform_device *device)
 		acer_backlight_exit();
 
 	acer_rfkill_exit();
-
-	if (platform_profile_support)
-		platform_profile_remove(&platform_profile_handler);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.47.1


