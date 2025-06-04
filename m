Return-Path: <linux-acpi+bounces-14116-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E9EACD427
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Jun 2025 03:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A2EF3A2B61
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Jun 2025 01:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7702D26F454;
	Wed,  4 Jun 2025 01:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVBDrgSF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C04C221FBC;
	Wed,  4 Jun 2025 01:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748999111; cv=none; b=ZvPy021/oSU7vsfBjdHh5yhpKqnLa+r3EZf9RH+RsvOwqVujYL3LKg32+/cu/4j55vgjwXy7JFJ5LuC7EPyZq+/lXTSw6lCWWZ3Prd437wVWV7nwqVnPOuAk5TiSjQM4ryjuf+uRHJ3KOpAP+gJoHjcM/4QRsi0JtCvWTM+tW7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748999111; c=relaxed/simple;
	bh=eg/zLg7Fd6NeLLjbs+dsRloN4kgqdjGrUDwG/onLsZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZsKNYQpIMp7Gzm2cGkMJIb40RO4MBrPRtTnz8PrclfUoegu3Vb3wX/iGPcx9bQvr/neltaUlCO87fPhNQfwjNa5YH4z6acdIJKUy0U6ZWGJ2+M4P1i+Ha1fAErMi67DIKYWgy4+9PDNNYryAMEmtmJidVX1DWtEmN2lV3DRKvCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVBDrgSF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239C2C4CEF3;
	Wed,  4 Jun 2025 01:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748999111;
	bh=eg/zLg7Fd6NeLLjbs+dsRloN4kgqdjGrUDwG/onLsZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hVBDrgSFxiXNVV/gz1ojGUwRZ/Jt5CyyvrIIeIWBXLRvkZXyAcFUl9ASmYtpVyaNZ
	 6d16kMqUNBkAjumSWdwJo0WqOY+KT1wtjJXQWFjMWdZsyYNoRQUhFyomBez7C1gem0
	 u75rwxnJgqzrMCPulysZb87JeHckMihY+Dswp861Zxa5RnK4AMv2t/m9OuMyiN/5yI
	 nwt8ScI/dM37lgoz6ce4gt9vE80Kr0RpDlCEKkgCzKVhfcD81RKo2x0WPE2I/pRsLE
	 BrJHnKCWKW9h1qiD6P5vaPA0bRSygpU6qLG3bNycu26YcMok1tWapZRzwfum92DwRw
	 /nRn8N4BLzfYA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Zijun Hu <quic_zijuhu@quicinc.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	dakr@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 38/46] software node: Correct a OOB check in software_node_get_reference_args()
Date: Tue,  3 Jun 2025 21:03:56 -0400
Message-Id: <20250604010404.5109-38-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604010404.5109-1-sashal@kernel.org>
References: <20250604010404.5109-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.140
Content-Transfer-Encoding: 8bit

From: Zijun Hu <quic_zijuhu@quicinc.com>

[ Upstream commit 31e4e12e0e9609850cefd4b2e1adf782f56337d6 ]

software_node_get_reference_args() wants to get @index-th element, so
the property value requires at least '(index + 1) * sizeof(*ref)' bytes
but that can not be guaranteed by current OOB check, and may cause OOB
for malformed property.

Fix by using as OOB check '((index + 1) * sizeof(*ref) > prop->length)'.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Link: https://lore.kernel.org/r/20250414-fix_swnode-v2-1-9c9e6ae11eab@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

## Final Decision **YES** This commit should be backported to stable
kernel trees. **Extensive Explanation:** 1. **Critical Security Fix**:
This commit fixes a clear out-of-bounds memory access vulnerability in
`software_node_get_reference_args()` at line 532 in
`/drivers/base/swnode.c`. The original bounds check `index
capability_test capability_test.c f2fs_folio_analysis.md
ipv4_multipath_analysis.md ipv6_route_allocation_rcu_analysis.md
ixgbe_e610_set_phys_id_analysis.md linux lpfc_timeout_analysis.md
mac80211_mlo_mbssid_analysis.md pfcp_driver_historical_analysis.md
rtl_bb_delay_analysis.md rtw89_mlo_analysis.md
tcp_multipath_load_balance_analysis.md test_unaligned_diff
test_unaligned_diff.c type_size_check type_size_check.c
veth_driver_analysis.md wifi_mlo_mbssid_tx_link_id_analysis.md
sizeof(*ref) >= prop->length` has an off-by-one error that allows
reading beyond allocated memory when accessing `ref_array[index]`. 2.
**Vulnerability Details**: The bug allows an attacker to read kernel
memory beyond the allocated property buffer. To access
`ref_array[index]`, the code needs `(index + 1) capability_test
capability_test.c f2fs_folio_analysis.md ipv4_multipath_analysis.md
ipv6_route_allocation_rcu_analysis.md ixgbe_e610_set_phys_id_analysis.md
linux lpfc_timeout_analysis.md mac80211_mlo_mbssid_analysis.md
pfcp_driver_historical_analysis.md rtl_bb_delay_analysis.md
rtw89_mlo_analysis.md tcp_multipath_load_balance_analysis.md
test_unaligned_diff test_unaligned_diff.c type_size_check
type_size_check.c veth_driver_analysis.md
wifi_mlo_mbssid_tx_link_id_analysis.md sizeof(*ref)` bytes, but the
original check only ensures `index capability_test capability_test.c
f2fs_folio_analysis.md ipv4_multipath_analysis.md
ipv6_route_allocation_rcu_analysis.md ixgbe_e610_set_phys_id_analysis.md
linux lpfc_timeout_analysis.md mac80211_mlo_mbssid_analysis.md
pfcp_driver_historical_analysis.md rtl_bb_delay_analysis.md
rtw89_mlo_analysis.md tcp_multipath_load_balance_analysis.md
test_unaligned_diff test_unaligned_diff.c type_size_check
type_size_check.c veth_driver_analysis.md
wifi_mlo_mbssid_tx_link_id_analysis.md sizeof(*ref)` bytes are
available. This creates a window where `index capability_test
capability_test.c f2fs_folio_analysis.md ipv4_multipath_analysis.md
ipv6_route_allocation_rcu_analysis.md ixgbe_e610_set_phys_id_analysis.md
linux lpfc_timeout_analysis.md mac80211_mlo_mbssid_analysis.md
pfcp_driver_historical_analysis.md rtl_bb_delay_analysis.md
rtw89_mlo_analysis.md tcp_multipath_load_balance_analysis.md
test_unaligned_diff test_unaligned_diff.c type_size_check
type_size_check.c veth_driver_analysis.md
wifi_mlo_mbssid_tx_link_id_analysis.md sizeof(*ref) < prop->length` but
`(index + 1) capability_test capability_test.c f2fs_folio_analysis.md
ipv4_multipath_analysis.md ipv6_route_allocation_rcu_analysis.md
ixgbe_e610_set_phys_id_analysis.md linux lpfc_timeout_analysis.md
mac80211_mlo_mbssid_analysis.md pfcp_driver_historical_analysis.md
rtl_bb_delay_analysis.md rtw89_mlo_analysis.md
tcp_multipath_load_balance_analysis.md test_unaligned_diff
test_unaligned_diff.c type_size_check type_size_check.c
veth_driver_analysis.md wifi_mlo_mbssid_tx_link_id_analysis.md
sizeof(*ref) > prop->length`, allowing out-of-bounds access. 3.
**Security Impact**: This vulnerability can lead to: - Information
disclosure through kernel memory leaks - Potential system crashes from
invalid memory access - Exploitation through malformed device tree
properties 4. **Perfect Backport Candidate**: - **Minimal code change**:
Single line fix changing `>=` to `>` and adding `+ 1` - **No feature
additions**: Pure bug fix with no new functionality - **Low regression
risk**: Makes bounds checking more restrictive, safer - **Core
infrastructure**: Affects fundamental device property framework used
across many drivers 5. **Historical Precedent**: The provided similar
commits show a clear pattern - other defensive programming fixes in the
same `software_node` subsystem (commits #1, #2, and #4) were all marked
as suitable for backporting. This commit follows the same pattern of
fixing potential memory safety issues with minimal, targeted changes. 6.
**Maintainer Review**: The commit has been reviewed by Sakari Ailus,
indicating community confidence in the fix. 7. **Stable Tree
Compliance**: Meets all stable tree criteria - fixes important bug,
minimal risk, contained change, no architectural modifications, and
addresses a security vulnerability in critical kernel infrastructure.
The commit represents exactly the type of fix that stable trees are
designed to accommodate: a small, well-reviewed security fix that
prevents potential exploitation without introducing new risks.

 drivers/base/swnode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 44153caa893ad..fdea6b93eb30e 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -518,7 +518,7 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 	if (prop->is_inline)
 		return -EINVAL;
 
-	if (index * sizeof(*ref) >= prop->length)
+	if ((index + 1) * sizeof(*ref) > prop->length)
 		return -ENOENT;
 
 	ref_array = prop->pointer;
-- 
2.39.5


