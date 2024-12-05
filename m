Return-Path: <linux-acpi+bounces-9936-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6BC9E50DC
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 10:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8549928A638
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 09:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63591D5150;
	Thu,  5 Dec 2024 09:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V5UCWaV0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AAB17B506;
	Thu,  5 Dec 2024 09:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733389737; cv=none; b=LgT89VsizfLCdJsGWkec37aLOY9SFHWLvhmi5GKMgTBuzjGNreHqle8ftc9TbdJLD3oXxT9iKOziDNuMdpI3DNolEiulqGEB0M3slmwAKsi+wSh0FD0l5VjSOGLh1ivGr3K49O3+VuOsrk+5Fth+3V2zbttjJOmD4h7u0ejUsfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733389737; c=relaxed/simple;
	bh=gHlUUsDQWjcionp01/oa5PhHndYgSQWwZXgoskMtATQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGrHD/XhajnAwh7psrHqbODdXQ1x2y78wJU0czlJXUAC0S1S18ZRakoiP6mbq1HuvVjfehfkuSG0W/TP4IrV1/33LZwi5cCdqgWyH7rYJimUDdDE9Tre4JS4BrqQPF73rDnugChDzKxioTF4zw+fRr0G+jFD+TcKTBeecLhSvqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V5UCWaV0; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XrqfYbWhJ0Kmzg+uIbXWOSC9Pry0cFxHUfhAYZ5Cp5I=; b=V5UCWaV01FVcq5B7fgqZhw6p0T
	AjtuBonXSWxLr1fuTaPsFSVUs456p81KxOP3plQIh+yfvmxXzKeq5M5UfEJeKU5W26fjssACqKHlT
	GhC02MsfLXG60r4hbbQTeoG1e2IqHsyeRsLXvBjohszqemtJ2Dn0oHcTXCKb9DpJt7GX8PU91TBL1
	NWuHwHeKcid1cp9KahFcpjjTwUXxfM42IHRRRLf1ZEVo3qZhL3Gky+LLH6cO4K/rOU4HJgbR1dwT/
	GTNWDBvSb7fKr6WjzMm1b5SzcxNIvGE37uB1Shnn7UmXX2zKX4CejD5tJMiXfSC3JPDdJPGHLLPiq
	wrvdLSKg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tJ7ql-00000002oPl-05eI;
	Thu, 05 Dec 2024 09:08:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 61CA03004AF; Thu,  5 Dec 2024 10:08:42 +0100 (CET)
Date: Thu, 5 Dec 2024 10:08:42 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Li RongQing <lirongqing@baidu.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	"open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v7 04/12] platform/x86: hfi: Introduce AMD Hardware
 Feedback Interface Driver
Message-ID: <20241205090842.GI8562@noisy.programming.kicks-ass.net>
References: <20241130140703.557-1-mario.limonciello@amd.com>
 <20241130140703.557-5-mario.limonciello@amd.com>
 <20241202113512.GA8562@noisy.programming.kicks-ass.net>
 <8517db8d-c755-4fa0-8d8e-fd477060d033@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8517db8d-c755-4fa0-8d8e-fd477060d033@amd.com>

On Tue, Dec 03, 2024 at 02:27:46PM -0600, Mario Limonciello wrote:

> I think the *_present() calls make sense for the other consumers in
> suspend/resume though. Agree?

 *     cpu_possible_mask- has bit 'cpu' set iff cpu is populatable
 *     cpu_present_mask - has bit 'cpu' set iff cpu is populated
 *     cpu_enabled_mask  - has bit 'cpu' set iff cpu can be brought online
 *     cpu_online_mask  - has bit 'cpu' set iff cpu available to scheduler
 *     cpu_active_mask  - has bit 'cpu' set iff cpu available to migration

The distinction between possible and present is physical hotplug. Using
present means you care about that distinction. Using that for
suspend/resume strikes me as equally odd.

