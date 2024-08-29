Return-Path: <linux-acpi+bounces-7982-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F12964DFB
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 20:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D873828472A
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 18:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D7B1BA86F;
	Thu, 29 Aug 2024 18:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="adYnnH6c"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408451B9B2D;
	Thu, 29 Aug 2024 18:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724957071; cv=none; b=keL29IMFGhcd7X97YpTUIX30BuUwsxIlqR2jPJ+RtWPfTE476yk6/yj6im+02Zk7padOvp6xZX2/DDOPxuzeASMGhsioQJI+mdtymqF5BJ+AnkwXr/xuBQ7z4bwJ0mcAamjXxcdddFkSEMeAkjAyI4LIR95FJ7H0TMgJdYgyEz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724957071; c=relaxed/simple;
	bh=S4CkdgFLwOCb5lMnnxvQ1Y3NpKIZBPF/PKaHfWrYn2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hBwhLfKUjMdbCriLjlbam/VjBAeeXJUsCPCt7uhMJb/19voUaLIwliN8cjviV9HkdkD2kRswNQ/UPuPT6fw3VU58IuH8cnuGwogr18yCjN+RmwKJ+JTxSQodxGprB8HpOk3xxQBuVEC2siach3xP9/cK3rZdJpEvbQX/plfHVW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=adYnnH6c reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id ab6ddb748adf9e07; Thu, 29 Aug 2024 20:44:27 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id CA9C26A8C15;
	Thu, 29 Aug 2024 20:44:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724957067;
	bh=S4CkdgFLwOCb5lMnnxvQ1Y3NpKIZBPF/PKaHfWrYn2M=;
	h=From:Subject:Date;
	b=adYnnH6c8c9iK18mehjN9m6J8oIzNHewaK85KAiKjti6XOkadzGnZ3DlCZ/guF3sd
	 LCdj6of245q2l4GW7Byps9nnrfVwrlbKwt47IeGwP2okbcQskHAbLjs0hp6eO2k6fv
	 GVLpoHoBIRpiE2kiTwXnl3wqgrSNekOjMxbiRdSKrIwN8gg/jjA7aKjjqW/3B5Q2o1
	 dbQ8F9LYQOLK1sYW996ZTKl8gdvRFM8D2hJOSyFFoEL64/b4iw1tvfxq4WoFX8oplp
	 jG55SfI3aDPURUlbxl1+x5fnXrfMz7oQ+KitM0lXFK9Blx+ox611MHsHmXs6M1zj7/
	 eiusC+9ovxIWw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject:
 [PATCH v1 10/20] ACPICA: Fix memory leak if acpi_ps_get_next_namepath() fails
Date: Thu, 29 Aug 2024 20:35:54 +0200
Message-ID: <5980113.MhkbZ0Pkbq@rjwysocki.net>
In-Reply-To: <5819337.DvuYhMxLoT@rjwysocki.net>
References: <5819337.DvuYhMxLoT@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedguddvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeelueffveduueelfeeihfehleejjeekvdejveetueeuhfetjefggeekudelvdeuueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgrkhgvthdrughumhgsrhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Armin Wolf <W_Armin@gmx.de>

ACPICA commit 2802af722bbde7bf1a7ac68df68e179e2555d361

If acpi_ps_get_next_namepath() fails, the previously allocated
union acpi_parse_object needs to be freed before returning the
status code.

The issue was first being reported on the Linux ACPI mailing list:

Link: https://lore.kernel.org/linux-acpi/56f94776-484f-48c0-8855-dba8e6a7793b@yandex.ru/T/
Link: https://github.com/acpica/acpica/commit/2802af72
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/psargs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index 422c074ed289..7debfd5ce0d8 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -820,6 +820,10 @@ acpi_ps_get_next_arg(struct acpi_walk_state *walk_state,
 			    acpi_ps_get_next_namepath(walk_state, parser_state,
 						      arg,
 						      ACPI_NOT_METHOD_CALL);
+			if (ACPI_FAILURE(status)) {
+				acpi_ps_free_op(arg);
+				return_ACPI_STATUS(status);
+			}
 		} else {
 			/* Single complex argument, nothing returned */
 
@@ -854,6 +858,10 @@ acpi_ps_get_next_arg(struct acpi_walk_state *walk_state,
 			    acpi_ps_get_next_namepath(walk_state, parser_state,
 						      arg,
 						      ACPI_POSSIBLE_METHOD_CALL);
+			if (ACPI_FAILURE(status)) {
+				acpi_ps_free_op(arg);
+				return_ACPI_STATUS(status);
+			}
 
 			if (arg->common.aml_opcode == AML_INT_METHODCALL_OP) {
 
-- 
2.43.0





