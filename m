Return-Path: <linux-acpi+bounces-17338-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2284FBA35C1
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 12:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62F711C04EE1
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 10:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D842F3628;
	Fri, 26 Sep 2025 10:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVn17gb2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C2E2F360E;
	Fri, 26 Sep 2025 10:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758882741; cv=none; b=dpgdtmBcgCEMdVh2/ylm0ASyZl9QtuyCaWQ9f9ITcEBR62LlIYvzzv7vHjFCka4jyV2RXU38pqGpFcobo2DNbRT6SZCfhbwgbSf93rm2+lqvA+k1azVxf7jm21hp+er8EvbSLjibmqYc2IQlbEqwjiu5jJS/vWW2u+lRM3K+nUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758882741; c=relaxed/simple;
	bh=bYOt0EaE2kZMgpOBN8Es91AY0CjNsHiL7YOz/ra0dqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uEIDVw8q0QnJXvB5caAmB/9yB62NQDkAGuA4m95bccusLvkLTVB38Q5dq+PBvNj91sGUiYBtY/21xyhvKaImDLov9rLMKHHDHmggM5MqyIisTM+BtQ3rdzofy+5cingi7Wczi0K5XzLPsPRCss5KyDxpv0KBPm8KWAS3tp8LAPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVn17gb2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E666C4CEF4;
	Fri, 26 Sep 2025 10:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758882740;
	bh=bYOt0EaE2kZMgpOBN8Es91AY0CjNsHiL7YOz/ra0dqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JVn17gb27ClkBFh9M4w1KMvj2eouQu3AsJGiD8SJVY2GdfHJ6hj/lWXUi9CJRnBu6
	 ZwcBSK60cqaYVmrKzDWieLNT+i7re/ZJ/6QJTgNRFUe3ZQmpXOUpf9A7qmWAw6zgaE
	 bWMYATF3l4WiipzwhWpiJZwRpuFSJv3FmTrG150Vif4AiCsm2Dl9U9BACv+tvavr4d
	 rRDCROTv0Y4BsJGW2+EAHh35Ar6Y4HFsKVmPPQ1iyaosLCpfNYIVZGO4VpIG6Txhl1
	 MJZwlManWBWBIyclwtk5dkQTgFB6EoB/3v1YR+I6l1JbCa3KtxfS0z/L9XcvZQzYrn
	 0oIhGAuCUiNow==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Qais Yousef <qyousef@layalina.io>,
 LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Jie Zhan <zhanjie9@hisilicon.com>
Subject:
 [PATCH v3 2/4] cpufreq: CPPC: Avoid using CPUFREQ_ETERNAL as transition delay
Date: Fri, 26 Sep 2025 12:19:41 +0200
Message-ID: <3406003.44csPzL39Z@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5069803.31r3eYUQgx@rafael.j.wysocki>
References: <5069803.31r3eYUQgx@rafael.j.wysocki>
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
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
---

v1 -> v3:
   * Change the name of the new function (Jie Zhan)
   * Add a tag from Mario Limonciello

---
 drivers/cpufreq/cppc_cpufreq.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -308,6 +308,16 @@ static int cppc_verify_policy(struct cpu
 	return 0;
 }
 
+static unsigned int __cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
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
+	return __cppc_cpufreq_get_transition_delay_us(cpu);
 }
 #else
 static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
 {
-	return cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
+	return __cppc_cpufreq_get_transition_delay_us(cpu);
 }
 #endif
 




