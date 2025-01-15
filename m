Return-Path: <linux-acpi+bounces-10667-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB59A11ABB
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 08:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3138A3A6085
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 07:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC0123098F;
	Wed, 15 Jan 2025 07:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVk/YCv+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39C31DB14B;
	Wed, 15 Jan 2025 07:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736925217; cv=none; b=AiF0Ce+KUvs/ZICaGwk9Qig/FstE+am4Z5qTlVg9BZuFF2rAuxhe9sQ5vd8DhC+Pu7DXgbAp/6wwPvvsGXTYHAWl0Uvs3SAIW5KHiWFoNGv6CgZ5528NMfQEkExbS9VuMzIGyGAvwXH4MZZVmo2Qjnaw2ePasLbzT1Er+BDyCVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736925217; c=relaxed/simple;
	bh=l1pUfPFG3Xb1+3APAS7P5Zi8aCJaa/Ok9u1y0Y5YRSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HIhBmoB0QG9R3Qv+c/F9hUwl6TBAfVk9g5XZXo+LItc5UqSJLOzGC78CW3laECjop+h9cvdqxWx/sT5ol9f5KuV6ZOpLZMREX9xc0duLDCoF8R/LysAQZ/VQOyDCZ2sroMNJJadweryppmJn9CFu7IN5UCS96V7dBdkjhq/lDTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVk/YCv+; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4b10dd44c8bso2014094137.3;
        Tue, 14 Jan 2025 23:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736925214; x=1737530014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wghjY7wf+gvPQnVgT5iXRWKzHWDJQc8xdIKtAAVEgQU=;
        b=iVk/YCv+P9ZUYFul9sDDh2zPqd4MpyEPgUe4BiOs0wP56vzNPlDwnmQQnuF1zCxqZL
         czrC5wGW6OdNQjZr6s9TTO7quQMEhkV/TIZWM/mn+Zt9d6klq5uyHB5LfAj+NxYewuPP
         GcM2yUU64qQ3Lsj7q9g9AhpwP+7dclM8dkqBsEx18/BsfzXA7EgQSf2ZmLLohfSKyboV
         I4z+2JUdVh0ialYVOnATuG77zbcpsJFvOVYCDNP3ha25aJF0g/6mKRF9y3eizuGVCvDl
         JN+1fEAbNCUHoMir+vP5VvUBTeNmcIjkv4cnKnGYRw6RXEyFxZz83jvXTbAiqQNcZyMn
         84IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736925214; x=1737530014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wghjY7wf+gvPQnVgT5iXRWKzHWDJQc8xdIKtAAVEgQU=;
        b=Ysz0BRCtrT080XYhOiHaEDYkRxYWAGI+07jHx9qZl3z8/lmOz+oLkzyB/NTpyBhCSs
         Lz3KZCkVK0QSkG3zWj03TlnLiR+gK92o2lFSAqYcd2aEgLBV/9Q8Fc5fY+k+eOj4znTl
         XC3b1daL2zjvsy7zGukVeE8TAkaY80HRU/kpC4pOjrsQ0TiFZCon+dZNpynmM1YlW+1y
         dy6KVHBHnWuny32wDem1F9Ccs4SQ3FpWaGNRvrxy9lxmzcz6inbcMeCeKu+Zpkp6Sa3i
         yc+w2M1km1oodOWcWROx124Hzb2WBmhnuZtOUXy7wlC5YAW8E5P4zNe6OU0C+oK5MZ5w
         E7Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUOBdpoIfE7AID9o6uN8vLrUO3Bpfn0ZJuRXSRWzlhuRfO5aHe9GskHZZD5ORs3XLbopdoStm3jgI9J@vger.kernel.org, AJvYcCWGddRGZGVvA1VWpG2GKfZ1fPO7F7j73y9bbGNHwOk+YTGH5O0pdnGhsubhxc2qjqVz1OUE8q2PgIWMRdV5@vger.kernel.org
X-Gm-Message-State: AOJu0YwHW06G6CcmVrirW9nDwupb2aBTBItBbQL+kSKCzWU9ReWqAw1O
	YLY3hoz5no7hN40ZbeL7u7QcTaGruMUQg8Hxe/dIpz675sBgz5OtjaZ4cw==
X-Gm-Gg: ASbGncsX/x0J/8gswY/FUbwRDASeSck+1jdR8Yn1bvMVbRJICtRcQx+7/bhqITCAYUs
	2ifszOq64FNZkxT9jrtCHT4U28370j5OnqME+hnbKP6ITAYByelmQH8T+++fJtzSE3M4UU9Ldhc
	tjY59vTlr3ekxc9SqR/vzIETjN/lU5Vd6ZosbjQJLa9L4ypDLd24EA+XzcbqTDT00t6BiLadzY9
	Y4bGfg15cA0bMLgpMwq7aWFaFn4l/kG6cRXr8srLFjGdd5+AtSP3EFa7nQ9FOMF
X-Google-Smtp-Source: AGHT+IFGQ+2O2ACrPoA7Ik2FtD+4pzlrvBqDu/TUpD4WCXQxjtHvfQQeqd/CwC1dH64Ww8rXSzdeNw==
X-Received: by 2002:a05:6102:3e1e:b0:4b4:6988:b140 with SMTP id ada2fe7eead31-4b635e22704mr12594697137.23.1736925214076;
        Tue, 14 Jan 2025 23:13:34 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f033ffsm5084366137.6.2025.01.14.23.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 23:13:33 -0800 (PST)
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
Subject: [PATCH v3 19/19] ACPI: platform_profile: Add a prefix to log messages
Date: Wed, 15 Jan 2025 02:10:22 -0500
Message-ID: <20250115071022.4815-20-kuurtb@gmail.com>
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

Declare a pr_fmt prefix.

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
2.48.0


