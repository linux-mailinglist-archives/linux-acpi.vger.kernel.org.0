Return-Path: <linux-acpi+bounces-20852-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJO9LiFsg2l+mgMAu9opvQ
	(envelope-from <linux-acpi+bounces-20852-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Feb 2026 16:56:17 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AADE99F2
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Feb 2026 16:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AE7D3011C62
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Feb 2026 15:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A257B421EF8;
	Wed,  4 Feb 2026 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pgS9gPAy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0AD421EF2;
	Wed,  4 Feb 2026 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770220462; cv=none; b=CcEulJ5WRkxmujSINdV+fxJFOemRwetJ3YCTwOTRLD5X2YSfuYgO8gSh8dGXvQKCzhytqIrBeDuaPlRWUbsICoOCC18yM7j8X7liP+YbiIjikHg3R8+Bx6fiDwofpS2u8stQuy2m2dl3Mynr8rHdxeBnBpGLGMt9l2+An2owU6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770220462; c=relaxed/simple;
	bh=fRYibwlknChQdXUh18fv3yvOVZU02zR5pKqIH5LLfAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lJ62nqAm6hiJ0lIlNAdeXPFHWUkoy5HcGyi9b8PZXBE8q6/63B3OH2HRbqQxU6qs9f9J3/bYVUpjHLqdwNh8TeQMJRc9FyCpqtP+3KALauDd3UlLY1HbiOv1SgKtoQhWjJx+ccVOuZadmX3dbk4iT55D82tk11k92OUGt+CVFc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pgS9gPAy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614CISlw1880671;
	Wed, 4 Feb 2026 15:53:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=svyOtfh05i9lAYJpnQjECk/4tWrxOyuc+Jp
	9H07cFXw=; b=pgS9gPAylFCKMlO7wv+z2AF0ro0Ln69p5PzXyPd1Fjot9UZyhTR
	jG7jHRg6OqYkXLMCClYagunhx0PD4XACw2X7/gwuIMz2KC+c02iwSVB6PeuSjWrp
	zHb6jwNXDjW7nf/QEafKGSkH+Pe6GU8i06o/csKmToLkrYcqoL7mRLccZGbt57h6
	i+2wwUyfB+LMKiZgJi6aZURnsCk9EgngtaQqMED5KnMjNrh6EnjFoixtRF/anYxQ
	tx3RzKqtmpEnx3d+ZvH3r3aT6WTZU53/8l/bjVgShVybzwWllivOu38u1dmOyuDD
	ZxZwDNcvUP5/OQHeoSIBK025/dphgNZbR1A==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c43n9s286-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Feb 2026 15:53:45 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 614FrfjW022392;
	Wed, 4 Feb 2026 15:53:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4c1atmke63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Feb 2026 15:53:41 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 614Freq8022382;
	Wed, 4 Feb 2026 15:53:41 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 614FrerO022380
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Feb 2026 15:53:40 +0000
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id 101D522C9F; Wed,  4 Feb 2026 21:23:40 +0530 (+0530)
From: Anup Patel <anup.patel@oss.qualcomm.com>
To: Sunil V L <sunilvl@oss.qualcomm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>,
        Atish Patra <atish.patra@linux.dev>,
        Andrew Jones <andrew.jones@oss.qualcomm.com>,
        Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-acpi@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup.patel@oss.qualcomm.com>
Subject: [PATCH v5 0/1] Common csr_read_num() and csr_write_num() for RISC-V
Date: Wed,  4 Feb 2026 21:23:08 +0530
Message-ID: <20260204155309.763597-1-anup.patel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDExOSBTYWx0ZWRfX5ZjjbsI9io7G
 7Xjzoq+Mk478kr7GVY7arkXA16tk+x6NpX1sj2/YEAAEdy0CVvoO+LzElOIKCPsWCqbrdK3aGqW
 F3dvigAeMvZdA6JJeeXHZt5FoZJYk8zM6Bf79clJkNsCN2D+6MtRmIc/B6ADyQVGZUDzghcNrTh
 nRv1LvCfbSGjF7O46puwe+5N6mQDZCJOsrE14qKLJy8toXvwhV0Bdg/brDAaLPaBcYIam6ZzPKC
 eSdS0fDCTasOO2Ptdb1MKVX9lq9Dpiz4GCaxCzjnl4AtyCBHrI766IpLdCILA76XSSxews4WXe7
 XVCMd9mrbvNZ2RiH7jN8rdkCiq9L84YZRZdEcQNpvmblbRc+FzsQRmc8JQ16gYKOvP955d2eknH
 MfTrQTmjgLiYf7wKAuFMkDLF6GUm9SFGIQdNNHlU2BB2bqDQ4v/wobFtPrthCOPb0vc4jEnhEwm
 2rwITiguKSkzZdOlEDA==
X-Proofpoint-GUID: IYWU7pmDWoa_3IE3rO-THZXhu88FWpWi
X-Proofpoint-ORIG-GUID: IYWU7pmDWoa_3IE3rO-THZXhu88FWpWi
X-Authority-Analysis: v=2.4 cv=b42/I9Gx c=1 sm=1 tr=0 ts=69836b8a cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8
 a=97VCTQuGHz7arqyciaAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_05,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602040119
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20852-lists,linux-acpi=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anup.patel@oss.qualcomm.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 39AADE99F2
X-Rspamd-Action: no action

Some of the RISC-V drivers (such as RISC-V PMU and ACPI CPPC) need to
access CSR based on CSR number discovered from somewhere. Add common
RISC-V csr_read_num() and csr_write_num() functions under arch/riscv
for such drivers.

These patches can be found in the riscv_csr_read_num_v5 branch at:
https://github.com/avpatel/linux.git

Changes since v4:
 - Rebased on Linux-6.19-rc6

Changes since v3:
 - Rebased on Linux-6.18-rc7
 - Updated commit decription of PATCH1 to reflect the fact that
   we are removing sanity checks on CSR number which are already
   taken care by csr_read_num() and csr_write_num().

Changes since v2:
 - Rebased on Linux-6.18-rc1
 - Added reviewed-by tags

Changes since v1:
 - Make "out_err" mandatory for csr_read_num() and csr_write_num()
   in PATCH2 as suggested by Sunil and Drew. This also helps further
   simplify csr_read_num() and csr_write_num().

Anup Patel (1):
  RISC-V: Add common csr_read_num() and csr_write_num() functions

 arch/riscv/include/asm/csr.h |   3 +
 arch/riscv/kernel/Makefile   |   1 +
 arch/riscv/kernel/csr.c      | 165 +++++++++++++++++++++++++++++++++++
 drivers/acpi/riscv/cppc.c    |  17 ++--
 drivers/perf/riscv_pmu.c     |  54 ++----------
 5 files changed, 184 insertions(+), 56 deletions(-)
 create mode 100644 arch/riscv/kernel/csr.c

-- 
2.43.0


