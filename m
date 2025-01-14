Return-Path: <linux-acpi+bounces-10611-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3350A10B1F
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 16:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC0183A9C3D
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 15:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630341FA17D;
	Tue, 14 Jan 2025 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V47QQHrd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC041FA14A;
	Tue, 14 Jan 2025 15:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736869124; cv=none; b=CDdoUr8BdRy3MqV5lPHrylBn+7rQwteUaNl3RUazyJA2J8Y880wEmoGIyI1an9vh+HBTn7caqTdfBav0pMVyPjcWrHvuT49MDLzg6vQO3m32NCqWCkE9BcqAXdOdk9McifBkQBrYjGr6S6I1LBy+CbaKK+sEP9vFTUyAbKj+VG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736869124; c=relaxed/simple;
	bh=BpF7zlyobRyavklFqWh9FmkW1KIjC7GDvUvKS8Bn43Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZzBZpxzCruZFGIwBEowPIo7vRB2QPBeM7npgyOfGOMXLQLZZfwLcIxhmg0v5uvAIarUrTU9S1XopyAhbTr9cYDX1KjCqZD4W+mP+fcdjj9hwmaYRfFTp0i062Oa5v8CBXhGR156FxqD3mF0kdVi2V+urjuQlTZ+6Z4D3or38M6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V47QQHrd; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-85c5adbca8eso1442907241.0;
        Tue, 14 Jan 2025 07:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736869121; x=1737473921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KwAs06+8NgwgClMQfbi9xdkvs7kEq0JRxnfd/0ekTaw=;
        b=V47QQHrdkPbr8XSWLa9IFu526/fqYkhOcAF5pZvoNBozxEsip4+rfuffzgYRKNvkyO
         fmffYGcgibmJeMSpRO6foTYlrKTo8czdHt936dyTUn027ejgE230nwpdM2NP83g5DVWL
         F1j2xNy4ah7qfXHirOAkfIsBsT/pOMPal/bxLdF7P0qQ1L9Py7mQh+t3FxfNynV1c7jW
         m21dvH2+g6mwZrfhPydbKZd9XboBF4VGxHcNec6UVXg7GQ3Yuj46QgGxZlv6S8kqsGtm
         qhzkbZxC34fAYKEzcLabEFoyxchz6NDAnmjgdqaYHvt6WfbNvqvW01e7hWyfHxFN2o3Y
         rTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736869121; x=1737473921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KwAs06+8NgwgClMQfbi9xdkvs7kEq0JRxnfd/0ekTaw=;
        b=ILSSgvFJBkhQEFixW6l30vY4dKeCcT/hxdyrDAWB/768y3KNNdX0RAVVco8RSvQWja
         bYQy9x4uWaIYup+zAmgu3c/SSxUgWa+qvRFV640S8vlqXu0Su25Chbu+0VvkJh97bf/g
         avqzdZbeGUQCv0SgD2BOe0A/bqmGSACEsY2Acr8LpAIhaAtaff5vmlryeZ7IYYIkP/Kf
         EmF307oztaUStW5hqcmJnkEmtfZN8+EeDf3Tgi67Io2DjmCzWs3BVZ5piYtdju1qYfvN
         TR9aNDCDzGeQ9BRzVahaItWcoCgeLy1mbhP4CrZIki/pUKl1h1pkcbd6GY55dw/mzP9h
         4c0A==
X-Forwarded-Encrypted: i=1; AJvYcCWg9PkyD70hVUMvLrPFozjXfbQPesCNYblYvEi/+R3CE3ANglnyDGQUQmpyftqChqfVzLmDdEx1V8o4YnxQ@vger.kernel.org, AJvYcCXrFXvFEvEDPA6lBKL0EdFmh2d4f1krUKcOla1MNlX6bkoa9txlmeZvO3VGFoHCnNirxV8IzkYsDxBw@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8z8U1ll0Xn9ufnH4f0dxaKHK73/qY1kClWx5GIj2UMNY2/xWX
	z448rPdtisyBrjjyLrls7UKj+2aIF6HEOzyg3zQnTGzcelwAaDuL/dUokA==
X-Gm-Gg: ASbGncvo38w+pqw8ESdmlAyIzwGN99PIi4+mLwYSsJtGHzWWV6JUi0EiYZl3DWZEAjE
	AhAOCQh1pOkG9OkRpOffvV+Uycrk3/+SgLXhg8kysfyPuA2XNBaSm1Sdk5aTmNLVj56j3VKZwLP
	rt2KQDoF/57d9tmvk4Ihds5yBfEL88Xp82GbxXfH2Y2xrd9OQBUYbZW8sHQDZlX8No57BR2Bw6h
	Zh57RIzGfbZlPK1mXf/UWL253daQHC1EYaAW3lq+aNPeKjqMg20T3XepitAZPQX
X-Google-Smtp-Source: AGHT+IHBcnbPpkFftirE8nVnxE2mjw2KXz4jQXdTQM1rAV2q+e5KDuK4iRqdP76fFxdJdZi73OmAlQ==
X-Received: by 2002:a05:6122:1788:b0:50a:b604:2bb2 with SMTP id 71dfb90a1353d-51c6c536deemr20595746e0c.11.1736869121464;
        Tue, 14 Jan 2025 07:38:41 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51cd7c56d30sm277e0c.14.2025.01.14.07.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 07:38:40 -0800 (PST)
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
Subject: [PATCH v2 10/18] platform/x86: dell-pc: Use devm_platform_profile_register()
Date: Tue, 14 Jan 2025 10:37:18 -0500
Message-ID: <20250114153726.11802-11-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114153726.11802-1-kuurtb@gmail.com>
References: <20250114153726.11802-1-kuurtb@gmail.com>
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
 drivers/platform/x86/dell/dell-pc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/dell/dell-pc.c
index 32b3be0723f8..2759bb608b1a 100644
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


