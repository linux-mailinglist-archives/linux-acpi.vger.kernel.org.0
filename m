Return-Path: <linux-acpi+bounces-17309-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D251ABA06E5
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Sep 2025 17:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C727D4E2C4E
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Sep 2025 15:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9434A3043C8;
	Thu, 25 Sep 2025 15:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeiAN6Aj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B23301016;
	Thu, 25 Sep 2025 15:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758815292; cv=none; b=l3KejHQJYrK8Q+R1A7K/ExxCWo106iGJQ0lhk3aE/htNi1Vz+c5iyDd6c+phHc+rFOfhZzaf4dFJD9cqlrZHoTGxmhr2EpT/TtIDcVteHtZksjU0cM98xtz/0ZBKS1voU8sIvb3ZeXFL4u6v2RoVheUT/XDwLyJOAGK3b4eVK9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758815292; c=relaxed/simple;
	bh=vBFv7RjtkXs9t+ZLyfmGh+3RLZDX3C9qbZiRXK6lV18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sGpq90dHeZONrZJF6YwjFNOSHhM/h8Ngdy1en8ZijGIasYh77ME/YDxSWNuQAp0ik+F/Sl6amHrXiCynZzdieCC9sCE9/bHTmv1k+ovvT/oHqxiJDjut1hrjjTSTpJ8oFRgG2hfyyWCDRpZaOdO5dr5kzuk72L9u8g//PyFRw8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SeiAN6Aj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75BAC4CEF5;
	Thu, 25 Sep 2025 15:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758815291;
	bh=vBFv7RjtkXs9t+ZLyfmGh+3RLZDX3C9qbZiRXK6lV18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SeiAN6Aj8MqC2Wi3MGIEtoV2+7kCWGrU51qGHUcVNJT5EGhhqb1Av1mxZn9eVwomY
	 9MDa7OWqEVLz0uPEb/zLIkaknCUsspKyXAsrqBtC3/Aa2/xlpIJVqVUn3rgSK+Fdux
	 NovjldSsBEIKZlKG9X+Pa6fHizy/i/7MavEfB0JfjQPGtrg0Z7Md6jYTyiAxPosFeb
	 TeznGBHuxt6IULm1bjND2HfK1GxquCMaCe1q9Tyi26B8ImgP02qm7RVmx8Z7Q+H4Wv
	 kmHYEYw2f0KMleISY/+aLCVyjBg+eBdwxwpVRd/TbK9hkU6YCflOf/MTOmnrMFgUBy
	 5vEtx8DBugAOQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Qais Yousef <qyousef@layalina.io>,
 LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Prashanth Prakash <pprakash@codeaurora.org>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Subject:
 [PATCH v1 2/4] cpufreq: CPPC: Avoid using CPUFREQ_ETERNAL as transition delay
Date: Thu, 25 Sep 2025 17:44:47 +0200
Message-ID: <22867781.EfDdHjke4D@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <8605612.T7Z3S40VBb@rafael.j.wysocki>
References: <8605612.T7Z3S40VBb@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If cppc_get_transition_latency() returns CPUFREQ_ETERNAL to indicate a
failure to retrieve the transition latency value from the platform
firmware, the CPPC cpufreq driver will use that value (converted to
microseconds) as the policy transition delay, but it is way too large
for any practical use.

Address this by making the driver use the cpufreq's default
transition latency value (in microseconds) as the transition delay
if CPUFREQ_ETERNAL is returned by cppc_get_transition_latency().

Fixes: d4f3388afd48 ("cpufreq / CPPC: Set platform specific transition_delay_us")
Cc: 5.19+ <stable@vger.kernel.org> # 5.19
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cppc_cpufreq.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -308,6 +308,16 @@ static int cppc_verify_policy(struct cpu
 	return 0;
 }
 
+static unsigned int get_transition_latency_from_cppc(unsigned int cpu)
+{
+	unsigned int transition_latency_ns = cppc_get_transition_latency(cpu);
+
+	if (transition_latency_ns == CPUFREQ_ETERNAL)
+		return CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS / NSEC_PER_USEC;
+
+	return transition_latency_ns / NSEC_PER_USEC;
+}
+
 /*
  * The PCC subspace describes the rate at which platform can accept commands
  * on the shared PCC channel (including READs which do not count towards freq
@@ -330,12 +340,12 @@ static unsigned int cppc_cpufreq_get_tra
 			return 10000;
 		}
 	}
-	return cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
+	return get_transition_latency_from_cppc(cpu);
 }
 #else
 static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
 {
-	return cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
+	return get_transition_latency_from_cppc(cpu);
 }
 #endif
 




