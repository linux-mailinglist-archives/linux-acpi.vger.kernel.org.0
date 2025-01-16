Return-Path: <linux-acpi+bounces-10716-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDEEA12FF1
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 01:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 350D03A6C1A
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 00:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379A918DF6B;
	Thu, 16 Jan 2025 00:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdYXUCis"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D64945C18;
	Thu, 16 Jan 2025 00:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987328; cv=none; b=WAY+kb9JJKruNktd3H9iRF5bmll7T5GdkbURwVmO7gg/CuG3s/tKZ7ctig8leZPO0Q+mF5GZQWCp07QGjuc/967H3tPaX2/myu7f6+IdozImv5aIuQ/7NVCCHrQS0MSihucisyCEP3FsjztKDkCiUx65CXbUqaDVmBemwztDaaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987328; c=relaxed/simple;
	bh=tf3agz/yQ4+YuVcUo0n4xHxtsItY/QfcfG6wSMlJ3bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZqXUgeSCpqV1lSiwAKrEPbdJLAvvYpCV8/vzK8c5sF1MHQUBZe+GT24/7yTw3GDosGT8Ybt0ZEB3gep8Hhkd/9J2LslHS5qUkaeHroEIsuErtDNDHr0WjMF0l4BCIsvv8CyBJylp9p30EiP91wTSTaYTf7YnQB6d1rfA9O02ENw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdYXUCis; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e545c1e8a15so643139276.1;
        Wed, 15 Jan 2025 16:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736987325; x=1737592125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGfpz1gJR0mzcUohVKtWrM56Xk5GG0gK5qV9PX6GMzY=;
        b=LdYXUCispaqyZTz9BUfA8dRD5Ih15zg4tUWXPokU5KVfKyoIh5P7/cz9LCBa0ZHfsi
         m76RPB7a/09UqAexKB00Fj2ktDcLYPeh+GLPCUQI7T5Ao2OL/0YhfTnrM2SmDrgzO+jQ
         UvmHvVjOEEXCz23hXMKXBYK1NPb6QhGY3dzaim7XrV1Fj32cnHh3biDIsj4UuQ+cZhQj
         GaXPdrtlUu97LDqVY4YYCqN9ALrsfMwDnwKWPsNYU978d8+rk5ewIjWv/Q3fjzVRtJJe
         ukP/NHui31tPWXu51Nyr6c0wuxSNxf9ln4liqzlgasVZchHwG+d/4y6y3S+cVfY5nMDP
         ECdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736987325; x=1737592125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XGfpz1gJR0mzcUohVKtWrM56Xk5GG0gK5qV9PX6GMzY=;
        b=RKdSVMQNVdoWxpZvA0TReL1Cfwy/rQNrp49ueWO6LNeIaYx0r3LVnyLAEwN1mX+1sP
         FBuAHfG74OQkiqqm9q1tpnhELvxzvA7j8sXy8IADDlCGvySdhkoGa/5L/Nx4PA/TzTqY
         77w96RY60y1O+zkniNTCoitG6ylHcrIVH9e1SRH58ycSuN8B2vJBmdCF+mPtWhPInPRa
         1Tns57/GprrtIsGlF2puIjhX4XbHsU+JLczYRg71KReHs6Rgl5M/mQUlRizNNorw4Ti5
         uekDtvH9SLDSjQB/kMA9ebIPlInmhBqsiNgga1fRrukdqOxdha30DLDjBDXkRYwrhluM
         Mb4w==
X-Forwarded-Encrypted: i=1; AJvYcCWLadHvWxAQjZZdyqs2NaHncAVMayKC/7w8M1od+tpG7BmukqSuQsRkF6bANZV8K3mFKHzRobF/VbYFo6WC@vger.kernel.org, AJvYcCX8kqjFB6/ZWjqsf5QrJg0PPEa878eOz6QoLwafHyOMJZ6tFn43PyFVgZUjCNOuQOlLS8Ko+QCScO2u@vger.kernel.org
X-Gm-Message-State: AOJu0YxboiPY/CF0EcJq9jS5eGUn0ehfcW6gOiZkugo4tZDOSRtk1yP1
	KiXBozTTHBufSkz1tzIhdwLWL3YNNqkuyphLsI+pEL56zg4fVzdYZIo/Zw==
X-Gm-Gg: ASbGnculjW88I2q13XJt/cps7IQKtB2TjkF5qUkP/pvZRhpAxdu8Wt+LBFUw1V09Uve
	K6dlYUpDBrT6z6LZJ7iLj4cLunBd28cWjCopabM990wZZ4fKbpGLv1wBj2kIISiLMzsRR+FB3Ok
	y1/p3p2rRcT/dC7y1drhOH3JmS65vJDU6un6Pmi+CVJvE8jetAePREWTuEext9fW9nTTc0mMvuK
	x2UgwsCAwF3NGlRyRLnC68THHQ8XfhZpl1QTa0lo1A5BaIS5cHz7/zz5w6dGqjI
X-Google-Smtp-Source: AGHT+IGAkkUAXoV9MV6VA9Y3fdhemgc2f5vcqxgNw3Qy77/rTdlluZm8ul8MV4scM7E/OSwkoFMHtQ==
X-Received: by 2002:a05:690c:c8b:b0:6ef:4fba:8158 with SMTP id 00721157ae682-6f530ef3e96mr260308657b3.0.1736987325443;
        Wed, 15 Jan 2025 16:28:45 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f546c46bdesm27229077b3.50.2025.01.15.16.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 16:28:45 -0800 (PST)
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
Subject: [PATCH v4 19/19] ACPI: platform_profile: Add a prefix to log messages
Date: Wed, 15 Jan 2025 19:27:21 -0500
Message-ID: <20250116002721.75592-20-kuurtb@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250116002721.75592-1-kuurtb@gmail.com>
References: <20250116002721.75592-1-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Declare a pr_fmt prefix.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/acpi/platform_profile.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 4895f37dd549..c9e46b6e27da 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -2,6 +2,8 @@
 
 /* Platform profile sysfs interface */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/acpi.h>
 #include <linux/bits.h>
 #include <linux/cleanup.h>
-- 
2.48.1


