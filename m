Return-Path: <linux-acpi+bounces-13010-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDB5A87F2F
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 13:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C98AC3B83CD
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 11:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CD92980D9;
	Mon, 14 Apr 2025 11:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="MXUAssJT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from outbound.pv.icloud.com (p-west1-cluster3-host11-snip4-10.eps.apple.com [57.103.66.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8670296172
	for <linux-acpi@vger.kernel.org>; Mon, 14 Apr 2025 11:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.66.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744630638; cv=none; b=FyJeJ+QhFn+7kZOtwiFsZrU5dgp2S+GKWsf2hHh8PYaLrpzQ1L5Jg2hMF9kbxYiGpJezHPdUeU5t6G1d8eb/2upXXr3xsGUevRRMA20o1PYVxN1fQPdzIapYGrX24Pfsp8IN4uji/nLKTp8xcQfZnVn33GbyASwyIQ1xuTU/Dj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744630638; c=relaxed/simple;
	bh=3EBo1UHxZYVAcmeZV9xc2YWNG5Q6oU3vIpyLU8bvyfU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cMNKWLZ9CbAekqCYzOx/Vhn4lwJ133dPMIxUdd1acbW/AsxSVZR8gIZUjqpg01FqN34JbnEeJGcUXMIbcpygYj8RhYQfJ91G9Vv4+IfL+ud30R+0NXqK0Cyw1nWtgIWci2JHFj//jBWlpssryTY5E2VZFmOdVq9I572FPbqeyBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=MXUAssJT; arc=none smtp.client-ip=57.103.66.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=p8e+CRnCqVnQogA+DPQ8DMnACLzEiOrJ4MQ9MV7rE9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=MXUAssJToDn1ceQNlI983lijUL2j86o2lLT3txQk9h0heqmrNywS2kFDKpKkCdwE7
	 BmAWoGLJ46uSdQHA/XytlbvkSZ2s3C8om64Nn0DUGUrK6vjhPIWhGGtP6zuE775mJu
	 tsj17bSSlGqV+d8YEf7XI8Xb5dEp9pgyI4Dt70/m2VTjRnRtYiXokdAec05kV2YOJl
	 OtT21SCAhpv3Yi4DPR9MY5onybPid17HNy2a/yByQVLo4n+LaSpwACGpjjWcccvzyv
	 n94TaWdNyYo58sSEdQ6TR1AYT7YOoUaKWwUAUCmnIEGt9B66ITFfOwNSXFGv82Fal/
	 6t7vKStJ0sd3Q==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id B502B18000B8;
	Mon, 14 Apr 2025 11:37:08 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 14 Apr 2025 19:36:52 +0800
Subject: [PATCH v2] software node: Correct a OOB check in
 software_node_get_reference_args()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-fix_swnode-v2-1-9c9e6ae11eab@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAFPz/GcC/22MQQ7CIBBFr9LMWgxQ0NaV9zCN0elgZyEoKGoa7
 i527fL9n/dmSBSZEuyaGSJlThx8Bb1qAKeTv5DgsTJoqa00SgrH72N6+TCSMH23cU6dW9saqMI
 tUn2X2GGoPHF6hPhZ2ln91r+ZrIQUslPYW3RbdP3+/mRkj2sMVxhKKV8dL44MpgAAAA==
X-Change-ID: 20250410-fix_swnode-4986ff1b3534
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: PNdeonrmcnyICvDdkuvutbVxsSekGQt9
X-Proofpoint-ORIG-GUID: PNdeonrmcnyICvDdkuvutbVxsSekGQt9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_03,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=607 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2504140085

From: Zijun Hu <quic_zijuhu@quicinc.com>

software_node_get_reference_args() wants to get @index-th element, so
the property value requires at least '(index + 1) * sizeof(*ref)' bytes
but that can not be guaranteed by current OOB check, and may cause OOB
for malformed property.

Fix by using as OOB check '((index + 1) * sizeof(*ref) > prop->length)'.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v2:
- Drop the first patch
- Optimize comments for the secondary patch.
- Link to v1: https://lore.kernel.org/r/20250410-fix_swnode-v1-0-081c95cf7cf9@quicinc.com
---
 drivers/base/swnode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index b1726a3515f6fbe13c2186af1f74479263798e42..22bed2d35b2e89b6ac741c73b0190dfe67b35f71 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -529,7 +529,7 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 	if (prop->is_inline)
 		return -EINVAL;
 
-	if (index * sizeof(*ref) >= prop->length)
+	if ((index + 1) * sizeof(*ref) > prop->length)
 		return -ENOENT;
 
 	ref_array = prop->pointer;

---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250410-fix_swnode-4986ff1b3534

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


