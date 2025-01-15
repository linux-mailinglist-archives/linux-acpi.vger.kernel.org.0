Return-Path: <linux-acpi+bounces-10660-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5087FA11AA4
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 08:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E39623A3419
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 07:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619942361D2;
	Wed, 15 Jan 2025 07:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDxtAss5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47F12361CD;
	Wed, 15 Jan 2025 07:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736925165; cv=none; b=uKGBmYytnWaNtnK631nzORfvkFDmGqi6YgsgxNfd1Ncn+Fo28tqddeX/Dywy8nPjavy3uiwJc6jLfOl1IVtsMTgmO0YSQXPGG5qXI9azPSb4q8FiVdruN2VKimq3/m3QGCHmp6SV1c/GUu+CtgUFrcOFkhCNpazxgvIYF7FCoR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736925165; c=relaxed/simple;
	bh=E1PDiKWtIzx9DrFxfQ6dGzeyp3el/gCtXDZ5vSIUXhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjHhuAQewBya/EN2TnY0E7aQLGaDGUqycUyBaSbIgytuUwUeY36/nA+DfQmWVYjuL4pIfI7ByO9o4GEyv/OR2hDeHPCJJLYoI83kUvyMTw+whxHxkAFGYx7tXGCqryvb7ruO5Im5sbRrAmY59PTK0qGeJvUAd72XvWbslaCXiMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDxtAss5; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4afd56903b7so1938301137.1;
        Tue, 14 Jan 2025 23:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736925162; x=1737529962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HSK0zhDEMxd4tkmOOiUu8UbApn4gKIO3/NyOhkVPaoo=;
        b=fDxtAss5KwkGgREM9Lfr9wNtlkZTjFpgs6ob24h0ABaKrkaf433L9fQ4oQOnIWlTnl
         WkmUFIptzeM8syfBlim1xHv4sG4uothobX1pmGerjTuCz4EaG0aLc3NOjcqRUCmAUoNQ
         aNJFYnsv/a2g3sGSHvVHGKh1vHrdUXpHMu+FjfAW+sAZzMzBDnzTHeJjj+alGcfzteWL
         X9En1MPs7oCWQxczEiLVxz0F4s1zoAa+PsuRWhznPq+YvKbmDPtRDT9eqOPG5G7AGzn3
         E8WLuJ12Gq5Sobr5Jn35IDu6a0Q7jdHvb2LtBWzZ1hdjX+ixwHJxeOBY3yqkuU2bANxM
         K6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736925162; x=1737529962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HSK0zhDEMxd4tkmOOiUu8UbApn4gKIO3/NyOhkVPaoo=;
        b=fNLDMa0eQPxVRQFemLQb+0zNNLIhoFiwCieRnufsL6AHDAiwtbZVTDu5oD2VhHBPw8
         SehLEzu1rRig20ccjaUFqN+8gSqeAlY2IuXhYvprKeSZD4qkyNaYyWqhiNYbn6BGwudP
         ebCC8eZaDMFz5079VMzzGzASjTGXG/4kXsaEbbK4lKs2U4Cz4ShPcCuG33NAUc/oDyWu
         Bmsp8RQCPmxf5/7tGExkEPwYasbZKMiedlq2HpVneFmdDyFo5Am6XoC5NaE7GgpbkSIw
         QWie8I8Jzebtl3+a3Xybwd+bZZikYWb34S158jCL9nt9eR4lb1wW31u9k2k2TXNxT1kJ
         HghQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfqBcaAGu5GuMYN4AKCanAcl1nxTgICtn4hTiTqIf7hC3teWf5fm/wl03G66BdS8OBI1fwpTshoBQGBjmU@vger.kernel.org, AJvYcCXLsjXnKqpAEOYbL7Ug+xKslK04cq7pWC/UeIlJoaAb9DdW3jSDCtjVbaVZbqbk7ZWWjPqcLpk+5H1n@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2+5aap1kn/y0P+T6Zz+RGTUai2uz2zBIufIHghX0aasZliu/U
	FeaKyVcszMdP/Fp99MCerGyXmVrraoysnaAfj54DVHVMYy0LkOpnffdoqw==
X-Gm-Gg: ASbGncsOoN1zi4F0umbHVQXynL6fz8W2t7sE7GHLdx2s7WCKyM76LkzmF1lY5kX05bp
	yB0CEMAnCXjI3YfBBiedRnznMsYLUvRSxZSHZu2gShlxJZ8tR6T4iWrvCZGfE2jAkmza8S4ZKYK
	n3j4lPkf3Arek4ZL44kvdNhZPpRaXiT+odBjYZAKzzC5hAz23Cgf5CEzG+tzp9ECNfpry6St2K3
	rQkBRMNIqnXxr5baViQo6RFUf+uDJtpi0Ad2gEwYjOYkzk+GV44Yys6jiF6jWEV
X-Google-Smtp-Source: AGHT+IHLS1vMhIvA3+oiMZgfTw60397it8QMB5uyukRtv3c2B9UYTlqXGoHstOLk+5nQFCxB8HneWQ==
X-Received: by 2002:a05:6102:3591:b0:4af:be6e:f0aa with SMTP id ada2fe7eead31-4b3d0eccc9dmr24954908137.25.1736925162148;
        Tue, 14 Jan 2025 23:12:42 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f033ffsm5084366137.6.2025.01.14.23.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 23:12:41 -0800 (PST)
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
Subject: [PATCH v3 12/19] platform/x86: hp-wmi: Use devm_platform_profile_register()
Date: Wed, 15 Jan 2025 02:10:15 -0500
Message-ID: <20250115071022.4815-13-kuurtb@gmail.com>
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

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/hp/hp-wmi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 75bcd8460e7c..1304dfc65aab 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -1652,7 +1652,7 @@ static int thermal_profile_setup(struct platform_device *device)
 	platform_profile_handler.name = "hp-wmi";
 	platform_profile_handler.dev = &device->dev;
 
-	err = platform_profile_register(&platform_profile_handler, NULL);
+	err = devm_platform_profile_register(&platform_profile_handler, NULL);
 	if (err)
 		return err;
 
@@ -1714,9 +1714,6 @@ static void __exit hp_wmi_bios_remove(struct platform_device *device)
 		rfkill_unregister(wwan_rfkill);
 		rfkill_destroy(wwan_rfkill);
 	}
-
-	if (platform_profile_support)
-		platform_profile_remove(&platform_profile_handler);
 }
 
 static int hp_wmi_resume_handler(struct device *device)
-- 
2.48.0


