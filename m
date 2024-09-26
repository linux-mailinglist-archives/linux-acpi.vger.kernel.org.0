Return-Path: <linux-acpi+bounces-8443-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACF8987975
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 20:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC59D280CE2
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 18:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7024166315;
	Thu, 26 Sep 2024 18:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sh53+aA1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FF24A24;
	Thu, 26 Sep 2024 18:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727376836; cv=none; b=PoyX9O/LRB7VwPUt8046aHsSVR+wYMTCFd18/kKkkzWF/8txyjHB6zknzvshrXgLnNbTBZdwoKaY7NVQ6gNYametp+TfBdSYkxXJ8MG19i901/ypi0M9U+LrZaGAi3oDoaWuuswfp4e8vM26kxBBoTnBPjWnBeLtMArm/snAMgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727376836; c=relaxed/simple;
	bh=GjhL1DklTV864soyZ8shLVXWedXxRjEAjQPHytr+Lbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sbBQ8pq0sV1SbdBoXKTxBNp6Xa8uHgIgCNOnRFAAMdZlgEcrptk4S5qg+xPbby9r3pRsTCb18cpwoTzNvJBuxaBK/Aya056FETTnUO1yapBKpYrVv5SJD7WC4rHSL4fJLpKbbkAx+80Nx192RUHStwErI+D9wgPLIJaW7vMdf64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sh53+aA1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E045BC4CEC5;
	Thu, 26 Sep 2024 18:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727376836;
	bh=GjhL1DklTV864soyZ8shLVXWedXxRjEAjQPHytr+Lbo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sh53+aA1D1BqJffmLPj4DE6Owxvt0S/63gofJfCX+OeUUvXxpSzouXFynWYc40VpK
	 yqClJngTiWkPsB6KY5b0MteWFr2HTx2Ttlz8nD7v46QzXzNs1zoAJ0H2WcA8xbWsuL
	 /Rz3+gVN89XQuU5Sc6HfpfymBDUpY56efS6qKXuAqib6wuyzPANQx63L8pqFTzMxuY
	 lUbXOzSBpUhcktsAAWE07Ru19xMS444WsWa+NStGiGzz6fbkDPJLjBoaTssOLKdD+P
	 ygVHyRdFX+6tSQ32iLrapXRVRTWprRuMrowsfYMnMHqaHSdKFjHyDqAthr9RdkpLeR
	 w/e9ehEAUh/sA==
Message-ID: <a7b94f15-114f-4088-9920-8cef790fc354@kernel.org>
Date: Thu, 26 Sep 2024 13:53:54 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] platform/x86/amd: pmf: Add manual control support
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Hans de Goede
 <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, "Luke D . Jones" <luke@ljones.dev>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "open list:AMD PMF DRIVER" <platform-driver-x86@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>, me@kylegospodneti.ch,
 Denis Benato <benato.denis96@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20240926025955.1728766-1-superm1@kernel.org>
 <20240926025955.1728766-3-superm1@kernel.org>
 <CAGwozwGXh1RV96hvSEd3HQoKGY+DeRPrhcKMxJUu7STRZURsmg@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAGwozwGXh1RV96hvSEd3HQoKGY+DeRPrhcKMxJUu7STRZURsmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/26/2024 03:52, Antheas Kapenekakis wrote:
> Hi Mario,
> 
> It is fine to require a module parameter for turning on custom profiles.
> 
> However, distributions such as Bazzite use per-device kernel
> parameters, which, while user accessible, will not be modified by the
> user for 95% of use-cases. In fact, the Bazzite update system manages
> the kernel parameters of devices automatically.
> 
> What this would mean in practice is that for devices where this custom
> control may be used, the module parameter will be set globally for all
> of them and taint their kernels.
> 
> Instead, only taint the kernel when entering custom mode. If combined
> with something such as `custom_mode_choices`, only taint the kernel if
> `amd-pmf-user` is selected after that.

Yeah if we continue down a variation of this direction that is a 
sensible change to push the taint down to only when in it's actually 
been used, not just when the module parameter is set.

> 
>> +{
>> +       add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
>> +       pr_crit("Manual PMF control is enabled, please disable it before "
>> +               "reporting any bugs unrelated to PMF.\n");
>> +}
> 
> "Manual PMF control is enabled. If the device supports other ways of
> thermal management, please use those before reporting any bugs
> unrelated to PMF. If not, only if setting TDP is required for testing
> (e.g., under load in specific thermal conditions), proceed with the
> understanding that this module may cause interference, especially with
> the amd-gpu driver, the suspend process, and, if the parameters are
> out of spec, general stability of the system."
> 
> Antheas


