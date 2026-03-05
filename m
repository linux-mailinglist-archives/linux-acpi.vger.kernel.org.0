Return-Path: <linux-acpi+bounces-21457-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOaVGOH3qWk/IwEAu9opvQ
	(envelope-from <linux-acpi+bounces-21457-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 22:38:41 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C497B2188B4
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 22:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61F3C303B97A
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 21:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8695350A38;
	Thu,  5 Mar 2026 21:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jingkai-info.20230601.gappssmtp.com header.i=@jingkai-info.20230601.gappssmtp.com header.b="C0dVdSnh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303D22BEC43
	for <linux-acpi@vger.kernel.org>; Thu,  5 Mar 2026 21:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772746716; cv=none; b=rcp2l0rFTeZ1tLpvI9t/p90Bv1Ksc79q1i1eeQeUCs2CnR0wAHDek7boAmMdo8tda57z6Xrigay8kPq6JuBur0dQDG0IGjbPWcge//c0rtAJs0RZIsIHjaadDiC8jDx5aljuDNuVUTJIQ3gK17bmXoI+vkHsEYfUnaN7E00ALAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772746716; c=relaxed/simple;
	bh=tqzoOnM+ddukzM0vvaYeR2JhJDzkAb9o7VtGY6+WeXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TN5W61WpXjXCSH85y2XQHWb1UOcXIFSBKTKuxNSfDUQdzeEWKXiX+c0vvjpC7iJXNISvBdbDCzBMBQ11YLoFr6O5M8onIbfM1eNkgFmmVsi2aCweIqKfWlp1vJqPbst/PvRvRFnG16dvTnLZfUe++WoqGqLmVILu13W9Ms0Bt0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jingk.ai; spf=fail smtp.mailfrom=jingkai.info; dkim=pass (2048-bit key) header.d=jingkai-info.20230601.gappssmtp.com header.i=@jingkai-info.20230601.gappssmtp.com header.b=C0dVdSnh; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jingk.ai
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=jingkai.info
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439bcec8613so3484781f8f.3
        for <linux-acpi@vger.kernel.org>; Thu, 05 Mar 2026 13:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jingkai-info.20230601.gappssmtp.com; s=20230601; t=1772746713; x=1773351513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97m+rg7pW74rodZjzn2RUwDU4nnFC8jgOLFdI4H+etM=;
        b=C0dVdSnhf94cMD6D10cS63Tf4CDfLRboyIqj0XN1Eap9RPH7ft4XnWgzmv6EkQ58EY
         DtCpYNgSdmHEsF5cn4GQ5+VyT38876CIfYcXuxCWeIpg27J/Up5rV3q9jnFBJYGjDjjx
         D1wMF8iBSHgC+G8avYzC8lLFSYXGp2Plzk5uzyUMfpauSjHwad3YsQTsGJooHPOEc8k5
         M6s3VJuygjKx70G2Q7aJu1FEbGeGuFg1bIYryYmlmgkc07y7eBKQLoCG3pyjpDugAoN4
         26npe5xavMheih5UCvRPNB2BNjceFAch0/ng+fwUU788RKDc3oEPTqh9VbceNQ0B7i7K
         7cYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772746713; x=1773351513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=97m+rg7pW74rodZjzn2RUwDU4nnFC8jgOLFdI4H+etM=;
        b=rup2fts2UsSZs3v2+cnq4RwewCM4rgASJSeHSNR4p5ZsjDkHS/7G6+eUn13tVrBGQR
         2nxaceycyDF5hn5vxujMH2KjvZlkb499U9GKRXgFLS0A1Pji3Rs5sSV8IVq7jXGgFnrc
         ZIN8UqHTf6ZrWJZIdv2JJtnt+9NB52d2vBTyG6U5XhzmfvpggUDh7HqngnfNULqjCTI/
         X+nfjHoN2neX1WoMjjpKg8dsJ8qmsZkrdBx0LKdgzXyMmW8LARSvpQ4fkB0y54xqbBDX
         yxraw8JbvQfjXrk1eMAmpXSMhhGWWa4ZXUTVtwYIW+7iWJBZP4j40Q3LpOug6Q1AbvpA
         BEdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXeACPr6lsohKzQ2tp7uhNhe0i+/Rq935z4m6TD9NzX3R9Bzeb18z44DxvFvOG8igYPxurDiFyEnsI@vger.kernel.org
X-Gm-Message-State: AOJu0YwaBRadqBB17MiF3mZVRc9fJ95grpJ/Qxz9pZqayY7/1JZSlS7h
	wej/VbcW3je/m8yIPX2budukhDMt0m71D/OhYPoRXR5UYQxnqcXUy4gKj3WP781BhR8=
X-Gm-Gg: ATEYQzykGqyS0JuJVZuiKYCF8nvqQIlBeijqOwxVlPOlvHd4fZMVx8hHjClqSwYlmpb
	VFGR2uyb+J5aW/fRkN1fzc2Vef7YkHfZfA84ZwN1qtgU8TitphDcXSduDr+LJkyLw2tTgkKdTta
	n7QZyNihgCycSPzsHsYM4n8UYxr2AaDscLImt2ueyVk64YUb9lkkac/Hylc42QPDa4/Vv1XqtTl
	hmXD+pBvUe6hVY4ROEo1IgeXQ6p0bxrqJ0TeUkPReMU01ABk5XUcXZnxQj04kE86CwKUKEkUroG
	0orAF32A4szLolcg8rjz0DhhurcakLmhJdBpmaNguzdum27uZOaqWLdWLe+AZ0TO5IbA6Tdie9D
	gqX6hekA6m0k6Zn6Fz/Edn+4+rJSJF174zDVs/S0LDhu8ORZzPsHXS8ZEalMQDGS1AeVwDJfPH2
	sfQOWSl40ckvZaIULjSdW5aWNzYyyhbWnDW9QOTuh7n4w/WgcV8C3kTSZhWN/r3bb32QbHmj96X
	Sow1aN0osvEOrJWFzct5w1R3x0dz/Lzn1juip2Jrq/N7P7DQ0kywROuWtxpj06hV6tHzFNdRmqW
	ot4=
X-Received: by 2002:a05:6000:420f:b0:439:ad2d:99f7 with SMTP id ffacd0b85a97d-439c80005b8mr13313879f8f.28.1772746713039;
        Thu, 05 Mar 2026 13:38:33 -0800 (PST)
Received: from localhost.localdomain ([140.228.89.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b34b6252sm36380232f8f.10.2026.03.05.13.38.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Mar 2026 13:38:32 -0800 (PST)
From: Jingkai Tan <contact@jingk.ai>
To: rafael@kernel.org
Cc: sudeep.holla@arm.com,
	linux-acpi@vger.kernel.org,
	Jingkai Tan <contact@jingk.ai>
Subject: [PATCH v2] ACPI: processor: idle: Add missing bounds check in flatten_lpi_states()
Date: Thu,  5 Mar 2026 21:38:31 +0000
Message-ID: <20260305213831.53985-1-contact@jingk.ai>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260215002608.54934-1-contact@jingk.ai>
References: <20260215002608.54934-1-contact@jingk.ai>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C497B2188B4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[jingkai-info.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21457-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[jingk.ai];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[contact@jingk.ai,linux-acpi@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[jingkai-info.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jingk.ai:mid,jingk.ai:email,jingkai-info.20230601.gappssmtp.com:dkim]
X-Rspamd-Action: no action

The inner loop in flatten_lpi_states() that combines composite LPI
states can increment flat_state_cnt multiple times within the loop.

The condition that guards this (checks bounds against ACPI_PROCESSOR
_MAX_POWER) occurs at the top of the outer loop. flat_state_cnt might
exceed ACPI_PROCESSOR_MAX_POWER if it is incremented multiple times
within the inner loop between outer loop iterations.

Add a bounds check after the increment inside the inner loop so that
it breaks out when flat_state_cnt reaches ACPI_PROCESSOR_MAX_POWER.
The existing check in the outer loop will then handle the warning.

Signed-off-by: Jingkai Tan <contact@jingk.ai>
---
Thanks for the review Rafael.

Patch v2 as per review, flat_state_cnt is now checked after increment, and the warnings are left to outer loop to handle

 drivers/acpi/processor_idle.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 81f372c64074..dc4a24560d1f 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1068,6 +1068,8 @@ static unsigned int flatten_lpi_states(struct acpi_processor *pr,
 				stash_composite_state(curr_level, flpi);
 				flat_state_cnt++;
 				flpi++;
+				if (flat_state_cnt >= ACPI_PROCESSOR_MAX_POWER)
+					break;
 			}
 		}
 	}
-- 
2.50.1 (Apple Git-155)


