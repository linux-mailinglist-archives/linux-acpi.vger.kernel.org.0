Return-Path: <linux-acpi+bounces-10458-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 055CEA07B49
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 16:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14E7A7A2FB4
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 15:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E212206BB;
	Thu,  9 Jan 2025 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUA9irDf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBFB2206AE;
	Thu,  9 Jan 2025 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435327; cv=none; b=fzlewmlzn3QRhkAsPHRFPouNjfMuCndCXUTdHqDSdoGR5MwnEdWapM6ERdarGCKAqkcn+usP21Sb9zY3Tcp4mvkzXpm4/N9Gsf3CQ7SpzhNGCufL3dFcY05Jzdeehz8sFcyiIDCTqCLPNetVcUo1GwfL06a7rEZmYSHdfgPZcDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435327; c=relaxed/simple;
	bh=j0SkN7T4T/5f3rBo4tFthXYTLFlDzJG6wEc9cSOq9z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Thl152sYSoDDnWV+A95X6/7RXzpfzgSlkMk6RxcGsmE/dnIMIgpYQG0XVd5/sIq9Ky3oSQnaT9j82Or8L69f/zQckABeL53K+MQU4WQCCXtYWtVRA7gDnDSToejQbn4h8CC6OuhTuSeKXzwmorru2CGyuVFkYoVdJd3VSCTRIAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUA9irDf; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4afed7b7d1bso379862137.2;
        Thu, 09 Jan 2025 07:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736435324; x=1737040124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/iPeOvfqR3a3r89mRdqSnR+yrBxJ13wmx1V2/OlLHjY=;
        b=DUA9irDf6Qsds2L47JePYovMInaXKaaxo+Qqkt+fnT8irNZpgC9wJDcF6A0t2NP0ix
         FortFdx3mN0HA7AZc5FrTooDRfQxR9Qr8PXSv19AgUqOZEACMA3FcfbI7OgHyLN6cQfN
         g8Ufr62ou3nx6H44QkymGPV1xem6bUDg6eRm/HtkdNc6OapszDaSzN+ccEaL6BDH6P9R
         KHyoyHvBaCT7Yvv4iCyt+y55D9YwuPbth6lQSBadcxn+FmSwgpXNZWG9H8ydLSW6XRC1
         p2IaMX8WmYXIF8+8BXNqlGBLYBFyLgymVwNa5Gm2345IYB1K7VVOd6ov8jF1wN1g7TIx
         1Bnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736435324; x=1737040124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/iPeOvfqR3a3r89mRdqSnR+yrBxJ13wmx1V2/OlLHjY=;
        b=oE/lM9lGMbSzP47MltSjr9hzWpmhHfkw0LK/DjCPcWiZ27V/3UZr/ytMPiUnRYGUHY
         uu3Vh8UfE5Njsnq6kWAunphdYNnnCns8eXYaJrLfznHVS92CQJVLJCiXkkcE3WnbBFH3
         i8yx3x1jSe4Q9IC3LYt0pgttbONvxAaX09denVET2RHnoDTXAhPBq9ddQnt/4P9/LhNL
         RHtCW3eyuQU3x9hYS8MRpVJeXKeylYbmQTBQvngyhhcQ436RAf18r9A1P0u+l73kSxtx
         LTdIbcdks+w4tcG7xhsArksUPGLJRSwGYi1kJBe6rWMqPDD0+U168wpyCBvoOJByxcF+
         4SlA==
X-Forwarded-Encrypted: i=1; AJvYcCWC1YI6jFd2/CRu2cwnOuC5UIBEFylgaJihCHSGg7uw12Amu3oWk7CmCJyAtn9CRLySw/LqzfcLIqMs47sa@vger.kernel.org, AJvYcCWOFl+0wcpT/g0mFc1CzFnfs0kriEvWd7VANcG8dRUvLDjmUwbhFf2TO3lA8vIxBpfu2UeRj+pxB51p@vger.kernel.org
X-Gm-Message-State: AOJu0YyhC/bop2xKoQWwz2Jdc3kGxuZQpxx+1vi1CaMofgfYxgRB0W2K
	7wMNzhVkKAvg/iSyY0cjAq26SAnYhzfVLPMQN/X+vPb2jJbK0unp1WR4DkKO
X-Gm-Gg: ASbGncuTIunu5Qy9srjfR3xl9nEsA8ym0fkJp5Qums6Ldj67iVVVZMU+AQFErOHgFZz
	ZR7yWEgYaY/iPJzz23VN//hiZDNFDXe/tb3ZP3wEXg1ZFRGZqQBfbCJ1wYo43nAhOtryNE2pul+
	djC2M1ICXEn2nAtiI4MQbzPnL4Q6/8dcZgoiKmqW4aqTVXtXPRHM297TkcZRse/udlgJApV1GsS
	KfIajgEbNMZuMziHzvwT6kzA8lVuUWoNO/xdKnrvIRL4dTP8N7pfhv6zLk3ty/i
X-Google-Smtp-Source: AGHT+IF+xscYmEWQekuErTlAVFKKdQqn3JyBZsYrpGaTGJsFbmztIiP7BNf8GdvQl9CqmV5Q1g+27w==
X-Received: by 2002:a05:6102:b09:b0:4b2:cca7:7d51 with SMTP id ada2fe7eead31-4b3d10482d8mr5814670137.19.1736435324083;
        Thu, 09 Jan 2025 07:08:44 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f4a5ddsm1019887137.11.2025.01.09.07.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 07:08:43 -0800 (PST)
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
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Colin Ian King <colin.i.king@gmail.com>,
	Alexis Belmonte <alexbelm48@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Ai Chao <aichao@kylinos.cn>,
	Gergo Koteles <soyer@irl.hu>,
	Dell.Client.Kernel@dell.com,
	ibm-acpi-devel@lists.sourceforge.net
Subject: [PATCH 09/18] platform/x86: dell-pc: Use devm_platform_profile_register()
Date: Thu,  9 Jan 2025 10:06:22 -0500
Message-ID: <20250109150731.110799-10-kuurtb@gmail.com>
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
 drivers/platform/x86/dell/dell-pc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index 1b6e60a63491..dda6f13295e8 100644
--- a/drivers/platform/x86/dell/dell-pc.c
+++ b/drivers/platform/x86/dell/dell-pc.c
@@ -281,7 +281,7 @@ static int thermal_init(void)
 	thermal_handler->ops = &dell_pc_platform_profile_ops;
 
 	/* Clean up if failed */
-	ret = platform_profile_register(thermal_handler, NULL);
+	ret = devm_platform_profile_register(thermal_handler, NULL);
 	if (ret)
 		goto cleanup_thermal_handler;
 
@@ -298,8 +298,6 @@ static int thermal_init(void)
 
 static void thermal_cleanup(void)
 {
-	if (thermal_handler)
-		platform_profile_remove(thermal_handler);
 	platform_device_unregister(platform_device);
 }
 
-- 
2.47.1


