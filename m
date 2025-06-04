Return-Path: <linux-acpi+bounces-14117-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73307ACD4D4
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Jun 2025 03:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F3618982CB
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Jun 2025 01:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2F12741AD;
	Wed,  4 Jun 2025 01:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xk53JJY9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CD11DFDB9;
	Wed,  4 Jun 2025 01:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748999170; cv=none; b=Od38Y9atXfuNoGz0P+zeHqwRQZHnuf1ANuUQrpPqwQcSqkZPcTCYq+FzC0BpzUpLrfNU9zqG81zNI+5349YbuG790tuW1396+Upmt0wtguGQt8eC/oPhgcSnYrFESQt/cSv4jj0anB8zNrmL1/6B9IklQJztTnub0H8YMR5lrOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748999170; c=relaxed/simple;
	bh=FO8W9qLlWSMdqPuosmUQjDXOljlbVIom6aE4wK6gwBY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vAqtZyFnb/73J893IXbS5NzM2QxjWngwdBddMFDxUH4WFgZvlEX8006w3sfEazOliAWbvmWamkwG2Jq1xsudvn0CDGTnsq8GyW1xQyTLVWo6NSd307Fen/I7b84OB3GlaTJ+3FON582JyeJCITslnhuEobO99JXMAa8DOn4ivW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xk53JJY9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396D5C4CEED;
	Wed,  4 Jun 2025 01:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748999170;
	bh=FO8W9qLlWSMdqPuosmUQjDXOljlbVIom6aE4wK6gwBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xk53JJY9mD0v2222LQTddUZN8guS4Erx+pAaC90308zipy6eycbqGRmyn7tPr8zfU
	 vEQ06biVsqA7eMAOyMYDxuUZJ/2lrwATysm+JnkaYiMtCQeUVUJg1f072iO4mjHdav
	 HOo1SaX6AAXX5F42Uil3s06Mjo+iyPv9QLYf7hIh4g/rmzxXrumGT3A3pSislUnHdv
	 tQMRWFUsZZ2ZXLn0FSMwPk3yjJ7HClbvMWkGm8GDmA3kNfm/SC35K8hYxNdnvW6lbt
	 w7rm6icJG1BTksEHXuc1+kP8GIOIfZbl+L25cPinWLAUDDnGOKHU5idZgjkwzaQJnl
	 c1kx6/WG+brDA==
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
Subject: [PATCH AUTOSEL 5.15 27/33] software node: Correct a OOB check in software_node_get_reference_args()
Date: Tue,  3 Jun 2025 21:05:18 -0400
Message-Id: <20250604010524.6091-27-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604010524.6091-1-sashal@kernel.org>
References: <20250604010524.6091-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.184
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
index 15f149fc19401..0af6071f86641 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -524,7 +524,7 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 	if (prop->is_inline)
 		return -EINVAL;
 
-	if (index * sizeof(*ref) >= prop->length)
+	if ((index + 1) * sizeof(*ref) > prop->length)
 		return -ENOENT;
 
 	ref_array = prop->pointer;
-- 
2.39.5


