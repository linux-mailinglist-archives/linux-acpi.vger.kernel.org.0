Return-Path: <linux-acpi+bounces-16668-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB2EB531B3
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 14:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD9E74876D8
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 12:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F360C31D758;
	Thu, 11 Sep 2025 12:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psZsUwZt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C870E3128D4;
	Thu, 11 Sep 2025 12:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757592296; cv=none; b=SPx5QsHjuIcfjuSrO739i0VkbHYTACJGPQ2rpbO4yOO/FxSUJXWCwQSyLxxIdbVLikN+eRJE8kFcecyJkB0xc44lVbtUYRbPyx3zXuQ1QkFE11CW4CDx2suBE6U+a0h/+BVDzSv5VNh1+Rotn5kIJRI8iH/C9BWuYdOLGF1vJQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757592296; c=relaxed/simple;
	bh=PfSG7J+D1YXvousTbGjSna3BrbXANzA+C2Uksj373fI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pYxHYmv79ovHTxpOU6U8rXaA66/E8KuUvTTmdMTo2BjsfdWott7BYB/Ziv/9IIcrU9bFPI9eO/CPanenqjbGG9TaMHbf69Z4YFxx2cOO00KgfHcqkapVtMAkVdquzLypx3UCcCqBTCHOANOXGGJaeIEyaUydLJzOyBVwzTSwkyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psZsUwZt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C91C4CEF0;
	Thu, 11 Sep 2025 12:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757592296;
	bh=PfSG7J+D1YXvousTbGjSna3BrbXANzA+C2Uksj373fI=;
	h=From:To:Cc:Subject:Date:From;
	b=psZsUwZtyah2SCutNeT6o8/7OoRfHDDNXdZ3AJk3u1T4sfHQQJIO8PpovNfJYMsmU
	 0SiopT3PTQRlVuebAYQGIOkXsb/gqSNEmFv5KS3bWHaPzV+gyVKolMNepRSB0R/YDa
	 oiQDJboMN4GwDkCuQRHE1UpKGa00Wi78J0CsnteBdJb/CWRaLiPK/MZqLnsOxDtwsP
	 OsbkR8xukRqU8h6bn4lm/EG1DnZwFhB05tN8PxSjKIuNO5ttOE9HGUTsJeYuhT5fTq
	 xTgf3uNHpj/aHTfL7UzLHDHrHYBokbSO6txAOrnYug6OW9IbhQtCKt4eya8TUf4ER4
	 7mWLhwZmxXUaw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>
Subject: [PATCH v2] cpufreq: ACPI: Use on_each_cpu_mask() in drv_write()
Date: Thu, 11 Sep 2025 14:04:53 +0200
Message-ID: <5044667.31r3eYUQgx@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make drv_write() call on_each_cpu_mask() instead of using an open-coded
equivalent of the latter.

Also remove a comment mentioning the smp_call_function_many() usage
which is not particularly useful anyway.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
---

v1 -> v2:
   * Drop a comment mentioning smp_call_function_many() usage (Mario)
   * Update changelog

---
 drivers/cpufreq/acpi-cpufreq.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -318,7 +318,6 @@ static u32 drv_read(struct acpi_cpufreq_
 	return cmd.val;
 }
 
-/* Called via smp_call_function_many(), on the target CPUs */
 static void do_drv_write(void *_cmd)
 {
 	struct drv_cmd *cmd = _cmd;
@@ -335,14 +334,8 @@ static void drv_write(struct acpi_cpufre
 		.val = val,
 		.func.write = data->cpu_freq_write,
 	};
-	int this_cpu;
 
-	this_cpu = get_cpu();
-	if (cpumask_test_cpu(this_cpu, mask))
-		do_drv_write(&cmd);
-
-	smp_call_function_many(mask, do_drv_write, &cmd, 1);
-	put_cpu();
+	on_each_cpu_mask(mask, do_drv_write, &cmd, true);
 }
 
 static u32 get_cur_val(const struct cpumask *mask, struct acpi_cpufreq_data *data)




