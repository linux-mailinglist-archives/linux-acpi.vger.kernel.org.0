Return-Path: <linux-acpi+bounces-8400-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79546985CA6
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 14:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 085C4B224C3
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 12:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD1A1CCB21;
	Wed, 25 Sep 2024 11:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXwqEGXh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917831AD3F5;
	Wed, 25 Sep 2024 11:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265547; cv=none; b=V+JOyoLYhX4Khu/qLkC54dQ1iOSsi8GgXMOaVdsGujvBh80gx5WYY+iF6tea912pxqtzzdyhI4arPpOyz+1I03KZNYKK5VuHmVMZ+g/Mho8I16vdBP3cKpSWnKO122uhvMbUFgfVuZrq93auWgtLy/u7phlpbjBtIueQlha/LrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265547; c=relaxed/simple;
	bh=+vRT/9sKMUBWk8ChoX3rH60aEURssGy3Awjy1YZ6UG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cesoc6lPFLEsBdYDrVbZLI8xmL5zBssNYLqXiLJ2u/C2fqYRoyFwUphJZ5tcP0WiUxtEuoq9zs4qqHuZNAIh98Nffxq6fV407j9mnZO3eaj2bcm6MeuRiklIM3Vxg/20BH3XxhdBg+ha6c0UPiQiPdCYJI/UWe4Hkm6J5P/tBwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXwqEGXh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1CFC4CEC3;
	Wed, 25 Sep 2024 11:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265547;
	bh=+vRT/9sKMUBWk8ChoX3rH60aEURssGy3Awjy1YZ6UG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HXwqEGXh+Zcg85L4N8hD6EZPCRFmRYfP74lISZVqwSFBTVzdgZySz77DdzIYBfdeI
	 Q4KrABKfxpa+mEsFCRBJ4T7RTwmefUMxBIZk57lh/dFkgKBKKng+rRfCoCZJtG2dCe
	 q87Vi7gzGzc4otxEOv2M/4AVQdIzRx90SK4mMFN8kMp/H4LHiZwMM4E2rsDajSNFr2
	 Qd69N7wAlvc3ohx0gyXiMypkvGNFc7/InDGod/q2TfnhKhd24/Q8JFLJevFjXyKxBm
	 C7P+LH18QmI4UDVyfIJ998P/dzDn2DEOJl4OwYYQcH4KuEro3X7x0uYoyAiGyqLkZs
	 8SWQBCKEhxICg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	robert.moore@intel.com,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 6.10 016/197] ACPICA: Fix memory leak if acpi_ps_get_next_namepath() fails
Date: Wed, 25 Sep 2024 07:50:35 -0400
Message-ID: <20240925115823.1303019-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit 5accb265f7a1b23e52b0ec42313d1e12895552f4 ]

ACPICA commit 2802af722bbde7bf1a7ac68df68e179e2555d361

If acpi_ps_get_next_namepath() fails, the previously allocated
union acpi_parse_object needs to be freed before returning the
status code.

The issue was first being reported on the Linux ACPI mailing list:

Link: https://lore.kernel.org/linux-acpi/56f94776-484f-48c0-8855-dba8e6a7793b@yandex.ru/T/
Link: https://github.com/acpica/acpica/commit/2802af72
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpica/psargs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index 422c074ed2897..7debfd5ce0d86 100644
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


