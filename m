Return-Path: <linux-acpi+bounces-20314-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A56D1D1EDDA
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 13:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB8C03033139
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 12:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0495839C650;
	Wed, 14 Jan 2026 12:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6Cfv7HF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64AA39B4B3;
	Wed, 14 Jan 2026 12:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394566; cv=none; b=eAJQUU8hoJZ7SJZ5BG6tkBbopJ4NKvYTTdQxFQdQEqOrDKQNUYkvQpPnW41esEKnaSw2QusNHEnHS7jgi07v7mTWt2lLLEvCZBTz/ZGZrc7LacqUJtu1s1LMzXZTFHk5mh8iZ0gMxztghn+T5N0iAOj8SvENYRMyPB/dTj5dJ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394566; c=relaxed/simple;
	bh=gPojbZ1REKdEya0VZt/tjs+q+hEzuzjZ1dRMvaiaQAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oyg3RnLA5G0DmTiwgfuYrGv9+SBeKLn9OeMst6cAkrLx/wrqz8rHDodnwbPna5Aj2YABm/jDAyjMa9RcJi37UXgH014lGZjzoRUfMD7dPBzAiVHtOgJHpEW3mhjrAFrEDzuiqXv09aKJ6zkQtAdn3k0RiS/tU5VmxoJQtd6nLOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6Cfv7HF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB291C4CEF7;
	Wed, 14 Jan 2026 12:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768394566;
	bh=gPojbZ1REKdEya0VZt/tjs+q+hEzuzjZ1dRMvaiaQAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J6Cfv7HFkHhQgjDG8n0ctzjoX9CaanlYaRv2+E0Tr9fsTu9nyTLUIskWRR5gHfsHP
	 VR0idIF9IZOVU8Us4rTUWjtA5wQNPxuMGSiAt3g7fipyiQtHabfxt5I+lTx5LLtlGV
	 ohe28PR5oa31jByuiMedluXqNgHnnPWFwP/j6UgEAEHW8K2jkoAAUfTshoQS69kEA3
	 lk8zbfJ3oJU5JKUQgnXK8wzce78yKDKuROF7t/LJSSgfBv/lh2jU0USU9x6zjFky1s
	 TKNBxb7jpsr5W1NXj7+r20weqdQ4aaMq9hYRUWz6Ykvj0NUp8i4VAqIuJaLoieocIJ
	 k3r4l/LErWxMg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject: [PATCH v1 03/26] ACPICA: Add UUID for Microsoft fan extensions
Date: Wed, 14 Jan 2026 13:18:33 +0100
Message-ID: <5045837.GXAFRqVoOG@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12822121.O9o76ZdvQC@rafael.j.wysocki>
References: <12822121.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Armin Wolf <W_Armin@gmx.de>

Microsoft has designed an interface for reading/writing fan speed
trip points. Add the associated UUID to the list of known UUIDs so
that the ASL compiler stops complaining about it.

Link: https://github.com/acpica/acpica/commit/67f0202c0fb4
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/acuuid.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/acpi/acuuid.h b/include/acpi/acuuid.h
index 25dd3e998727..0eda9d997f31 100644
--- a/include/acpi/acuuid.h
+++ b/include/acpi/acuuid.h
@@ -71,4 +71,5 @@
 #define UUID_USB4_CAPABILITIES          "23a0d13a-26ab-486c-9c5f-0ffa525a575a"
 #define UUID_1ST_FUNCTION_ID            "893f00a6-660c-494e-bcfd-3043f4fb67c0"
 #define UUID_2ND_FUNCTION_ID            "107ededd-d381-4fd7-8da9-08e9a6c79644"
+#define UUID_FAN_TRIP_POINTS            "a7611840-99fe-41ae-a488-35c75926c8eb"
 #endif				/* __ACUUID_H__ */
-- 
2.51.0





