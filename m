Return-Path: <linux-acpi+bounces-2696-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC7F82318E
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jan 2024 17:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E5A5287FD1
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jan 2024 16:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89971BDD3;
	Wed,  3 Jan 2024 16:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwzSlwGR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8243C1C6BA
	for <linux-acpi@vger.kernel.org>; Wed,  3 Jan 2024 16:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-68025a84a60so14715666d6.0
        for <linux-acpi@vger.kernel.org>; Wed, 03 Jan 2024 08:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704300661; x=1704905461; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A9j7WAGZKg9d61IqRZ1X+qliaE3kMNCzTo87hR7CjZs=;
        b=EwzSlwGRrG9/LvGgIO0YCMRfs9IoQC/Kqgonx7ywm4pgy7Jtpg1RvT9Ncaz5e61bs6
         17gK79pO3xJD+dtUG4wGqV3Dwh1uCHEFOJb1tuc/YDoTpZ1sNmuUc35LHtp/Sjy7+hYX
         iRI7/Qd39Wcpcmn6JbpJts4uQAHUfcQSdhE9OJ9+IpZskH6Jm1Ni/5hTZI7jBFHQy16s
         R0kvUHZ6NNyg1sMqFZCWXUInVY1ps2dehgEolm/EUQIDGd3RQom5jxVAJyD3hg9CefIU
         OMSFV9cESNPpp/wJuq5GOTch/d4uDqrT2c5aTdWbQSTFMJCTaSt1YWJjVQw/gZqJhIH+
         LdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704300661; x=1704905461;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9j7WAGZKg9d61IqRZ1X+qliaE3kMNCzTo87hR7CjZs=;
        b=vpXQzS14b6hmjlupAY4JDt4ceafuvNX3w4Bf93S48ezkFI/S5x+vvEENG0J8gQ78TL
         SOOvnG8RP1GmWcXB/9YvathrlpNmb5teUw8joaYQlJssfuvzjQurzqYityun+6vYbpRC
         SnHWD9Cdp0uBRFugPnmqKqO1GWRBda89uMYBgA4qSgePh8BGgUmVvd+qSdP0Y0VnpCco
         V3hDeP2MlOqcDPrma4xPnP8VQdBadYSxgz3Yc6oTRDkUbl5ms5bxlRBxX8IdAy0I+FQi
         CCa6IdisuWOCn8s33QfQ4T+/ksC2+VpnkouAvP+mOAEOMSXKH/PtnTwslOqoPAyT7yPB
         uKUQ==
X-Gm-Message-State: AOJu0YwqWxfYKPM7fYld8iJUxoXRNkM2cZeFnvOPG3kWancXau6dw8tt
	7YAY3En2TKaQkt4FgJbLEsG+0KLCgHk9CA==
X-Google-Smtp-Source: AGHT+IHTwGCSSIxaD6Q+wUkJzZWVVdv67pC6+1nHPJiVRpJ9ueCSBxh9nRV3UFOPXpl8E0FGLJ+Tzg==
X-Received: by 2002:a05:6214:c45:b0:67e:abf3:8be3 with SMTP id r5-20020a0562140c4500b0067eabf38be3mr40185601qvj.3.1704300661434;
        Wed, 03 Jan 2024 08:51:01 -0800 (PST)
Received: from davidm-laptop (hlfxns018gw-134-41-185-34.dhcp-dynamic.fibreop.ns.bellaliant.net. [134.41.185.34])
        by smtp.gmail.com with ESMTPSA id d11-20020a0cfe8b000000b00680c25f5f06sm1444876qvs.86.2024.01.03.08.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 08:51:01 -0800 (PST)
From: David McFarland <corngood@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,  linux-acpi@vger.kernel.org,
  Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4] ACPI: resource: Add Infinity laptops to
 irq1_level_low_force_override
In-Reply-To: <87edey4bcp.fsf_-_@gmail.com> (David McFarland's message of "Wed,
	03 Jan 2024 12:42:46 -0400")
References: <20231230150916.1843117-1-corngood@gmail.com>
	<CAJZ5v0jab+jao4=7r1LOJhNn2Pq2fc_nQ1KS02_=9Z30Eyww9A@mail.gmail.com>
	<87il4a4ipc.fsf_-_@gmail.com>
	<fe82ff9a-3d9d-43a6-ae83-7b9953d3cb5d@redhat.com>
	<87edey4bcp.fsf_-_@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Wed, 03 Jan 2024 12:50:57 -0400
Message-ID: <877ckq4az2.fsf_-_@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

A user reported a keyboard problem similar to ones reported with other
Zen laptops, on an Infinity E15-5A165-BM.

Add board name matches for this model and one (untested) close relative
to irq1_level_low_force_override.

Link: https://lemmy.ml/post/9864736
Link: https://www.infinitygaming.com.au/bios/
Link: https://lore.kernel.org/linux-acpi/20231006123304.32686-1-hdegoede@redhat.com
---

- v4: fixed rebase error, adding to _force instead of _skip

Apologies, I messed up the rebase.  This one should put them in the
correct array.

 drivers/acpi/resource.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index c3536c236be9..0e2c397b1399 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -555,6 +555,18 @@ static const struct dmi_system_id irq1_edge_low_force_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "GM6BG0Q"),
 		},
 	},
+	{
+		/* Infinity E15-5A165-BM */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GM5RG1E0009COM"),
+		},
+	},
+	{
+		/* Infinity E15-5A305-1M */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GM5RGEE0016COM"),
+		},
+	},
 	{ }
 };
 
-- 
2.40.1


