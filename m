Return-Path: <linux-acpi+bounces-16534-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9003B4AC61
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 13:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A54F33A3466
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 11:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C546321F5F;
	Tue,  9 Sep 2025 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3IhVLci"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AFB31B82C;
	Tue,  9 Sep 2025 11:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757418095; cv=none; b=JeaNYTaSvYHOcV2nZKxUi9S6106oxr7M3OTcdlPQfz3OpA0paMecMxluF5Kk25zycojLh8/heZ0NIeQla6iOUndibmHQRKw+g0fYS64pzHZAyIqFv6aRereveqZxyC1l5Ux1NobVV4Ev4lT2IDlTUsqSlx9Ipf906gYOcqwuKhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757418095; c=relaxed/simple;
	bh=csnciOLr7bNNQ5Y0SzQdIQW4n35Ea4AWAZOFdz0lb74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OdrEvyhVKEWO4QnTHmCeZb771jXp94eJeoSonJxCaQ93YAJqDBXuZJFMZ2tTKWx2XU50pBg+Y2qGFI0qERaLKw6A1yqzdu1QqY7DrH6MuQ9CAWdcyM05vT+g6F72dAQpnDZm4VGQA0pTq4UOfjprh8R3PqRWIaBHd29XIK8FwhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3IhVLci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51586C4CEF4;
	Tue,  9 Sep 2025 11:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757418094;
	bh=csnciOLr7bNNQ5Y0SzQdIQW4n35Ea4AWAZOFdz0lb74=;
	h=From:To:Cc:Subject:Date:From;
	b=E3IhVLciZ4eOif8XOYK5Wf7e8WOLhx6X5lT5LEXmD7fe1BDvutk03xuusIgC1v+3r
	 C3FPsD9kiwEJaZFgMomw0UjrFvpKHRxX2Si6PzRmJYWlFyZTmTGMIQzZo96ZIdZ7JR
	 lz60YkARr4DTwZ3RDk9z4prp9EclbCmfVfl5OHFTqDNBtJlpXvpRnzYhaEDnklCc2c
	 PVXRQms3YnhSAjw59oAGABuD7gkjm1sx1AKZu7KaI9fJvt1q0QGF0EmsX/3PQdTABD
	 upNSeKZslIOIdq4pnKtadTV8wiNTACBb2avYcevV4sJKSDqVsWhmD1rSPjt8wtVhun
	 aQiEA9I7/B2qw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Gautham R . Shenoy" <gautham.sheoy@amd.com>
Subject: [PATCH v1] cpufreq: ACPI: Use on_each_cpu_mask() in drv_write()
Date: Tue, 09 Sep 2025 13:41:30 +0200
Message-ID: <2797300.mvXUDI8C0e@rafael.j.wysocki>
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

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/acpi-cpufreq.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -335,14 +335,8 @@ static void drv_write(struct acpi_cpufre
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




