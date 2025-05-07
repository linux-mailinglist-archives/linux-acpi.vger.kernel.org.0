Return-Path: <linux-acpi+bounces-13521-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A618AAD47A
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 06:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E76DD4E76F4
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 04:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AFB1D5146;
	Wed,  7 May 2025 04:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HukbXTdL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553383596F
	for <linux-acpi@vger.kernel.org>; Wed,  7 May 2025 04:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746592370; cv=none; b=aokxpiaORZGCWIbh4qdrQ/Aoj/U0fvE95u0a8G5eD62RVafEbzf1tqH3CaqqsQuVico+9soTjORVCrN7CAtkK5+nI/9bLxo1Uu92StOTBPIIX9gnI2EegYgC5O/pjAVQNP3m0avhLsB5vAg1pzBr6xMF85J/4Y9vrWrpM+6HQCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746592370; c=relaxed/simple;
	bh=niuKy9gk4dkCS6rlhCHtu+URATrBywypRfYoWQZ9nt0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QwsaDp1wLCXgPxfRCdmHDsP0tdBLjJ0yDpjeM7QYD/e8nKef7UIIFSpFh5VgwJJE75ryUrRw7x4SykkuUVxleuDVG/X6hsrpXtBqEiWKZ97DbRjQhRi2IiMQsOGYByai7ix36X1YzBSo6k/W5nAJosMd8nASG0A/e5ucr+WNYyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HukbXTdL; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22c336fcdaaso80906905ad.3
        for <linux-acpi@vger.kernel.org>; Tue, 06 May 2025 21:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1746592368; x=1747197168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y7qKabiFtKwBUMZkvyHIungLeY3bn69kzVyg50ugsVA=;
        b=HukbXTdLEvehiR2iTkJcraQqlCiyMwWrtrrDQj7s+S72vXBXNARF9OH961MO/IFecn
         Tsr/D0xuE7xQJyAWWVuJZT17+3uJE6uCsn8Lu1CcXDrdh/iOhPWXVs3KkR0k62aV/op9
         d5XCCl4zCYcU3KB5At/KQEv+YXBmIycpXTyBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746592368; x=1747197168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y7qKabiFtKwBUMZkvyHIungLeY3bn69kzVyg50ugsVA=;
        b=hAcv7v/1Z19xQHKaCQlFwkLD5qUzIQbujVbHSOXa2EyBObQ3D2SnZKV5m8bejitvDP
         pEkj6cAubeil8ydryo3Ug/PdSZHH8u0Xr7oMEDtgdMiknxK01nmKn+xRel81DejAzrN+
         aZhpSBQOsAP+6oPcluVs6Im+aDXNxk/7QzAHZCJGih/gi02IcGfPBfgGSo2JbWB9Aovj
         ys16UDCsPjX/UG7HfPQvSyjS3UxVZI/KKUE0FJPkBcs82S8i4Eo5kqF9JX3zxiU4q2eb
         nz3Jkm4gnbP5GzNUW+QdAZ5TOgJcPzHDS7VwxFqHlhDIqLGv9r6mJsytVba4/hCnEYA9
         8+Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVzk4mVdZOSScj8EfXMU7JC5PKU2m7qgPMVBpGnzVDkWFwzgWomCj1AMhexGoxMpImBmNytBYc2/zsd@vger.kernel.org
X-Gm-Message-State: AOJu0YxNB16LIc/z96MbnnbooOG8XHDiQHxRrxiL++IwgLSIuyOyia57
	GGEqRoGYtK82VLMayfnd7i1MMM7po+fIs0NKPgxqv18c8fPQLE5BI0uLBIS6KQ==
X-Gm-Gg: ASbGncu25vxHvIkVKH3a6/xOHnfJx6CqaQJoEAahaicjD3HZ6Bzlt6kYhAd7LXtZQFu
	TeCgt571edw0WDV0h8NI6xvyiKVjSbFeUKLbuQ9g0EhbtY6PWRMrc4QNRLulBHgwouhldbN5zql
	zMXyhlQzYcx7dZRmxRug3hSQT5tsegQdWBm/CeRjxpjGLdzRu7iWVBy9Gqy+MJEiCA9VUsa4OiH
	0UL/wUFkk76rxS/47a2t+yKAwEAp1QgQp7T7wibwpErOyWXDxlPlxQWy8FgchbQVDiiUU6HxeRx
	Pz105Fhsg7u4hceULJPvEFa2GHAUeDW+afkffqA=
X-Google-Smtp-Source: AGHT+IGIkODBbXRNjMj4QG+fj5A2bZSDzZK4M2PphSMZPfCaOncGd4wT+3d90LYXEUxDmSPl/uFFgA==
X-Received: by 2002:a17:902:d509:b0:215:b9a6:5cb9 with SMTP id d9443c01a7336-22e5ea2e057mr32529895ad.5.1746592368455;
        Tue, 06 May 2025 21:32:48 -0700 (PDT)
Received: from localhost ([2401:fa00:9:14:dc6d:cdc2:d5e4:9262])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22e151e97eesm83937725ad.71.2025.05.06.21.32.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 21:32:48 -0700 (PDT)
From: Peter Marheine <pmarheine@chromium.org>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	Peter Marheine <pmarheine@chromium.org>
Subject: [PATCH] ACPI: battery: negate current when discharging
Date: Wed,  7 May 2025 14:29:54 +1000
Message-ID: <20250507042954.43674-1-pmarheine@chromium.org>
X-Mailer: git-send-email 2.49.0.1015.ga840276032-goog
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ACPI specification requires that battery rate is always positive,
but the kernel ABI for POWER_SUPPLY_PROP_CURRENT_NOW
(Documentation/ABI/testing/sysfs-class-power) specifies that it should
be negative when a battery is discharging. When reporting CURRENT_NOW,
massage the value to match the documented ABI.

This only changes the sign of `current_now` and not `power_now` because
documentation doesn't describe any particular meaning for `power_now` so
leaving `power_now` unchanged is less likely to confuse userspace
unnecessarily, whereas becoming consistent with the documented ABI is
worth potentially confusing clients that read `current_now`.

Signed-off-by: Peter Marheine <pmarheine@chromium.org>
---
 drivers/acpi/battery.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 6760330a8a..0ef03142fd 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -242,6 +242,18 @@ static int acpi_battery_get_property(struct power_supply *psy,
 			val->intval = battery->voltage_now * 1000;
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		if (battery->rate_now == ACPI_BATTERY_VALUE_UNKNOWN)
+			ret = -ENODEV;
+		else if ((battery->state & ACPI_BATTERY_STATE_DISCHARGING) &&
+			 acpi_battery_handle_discharging(battery)
+				== POWER_SUPPLY_STATUS_DISCHARGING)
+			/* ACPI specifies battery rate should always be
+			 * positive, but this prop is negative when discharging.
+			 */
+			val->intval = battery->rate_now * -1000;
+		else
+			val->intval = battery->rate_now * 1000;
+		break;
 	case POWER_SUPPLY_PROP_POWER_NOW:
 		if (battery->rate_now == ACPI_BATTERY_VALUE_UNKNOWN)
 			ret = -ENODEV;
-- 
2.49.0.987.g0cc8ee98dc-goog


