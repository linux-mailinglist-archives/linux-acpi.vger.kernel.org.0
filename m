Return-Path: <linux-acpi+bounces-6300-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B505903AF9
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jun 2024 13:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D35001F226F2
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jun 2024 11:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D18F17B4F8;
	Tue, 11 Jun 2024 11:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="w/WNpD8j"
X-Original-To: linux-acpi@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F240C176237;
	Tue, 11 Jun 2024 11:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718106159; cv=none; b=hn+ZkKW+l23yHA8O3K3pRi7HXFWqN6dhuHVhApLTiHYn6nTW86TA/kWzUGLPkxhMwr1RxSfnpgz19P27WhyCzaLhT0uTIjRz+brnFy2fsCb/t7AFgY6TmtezwY2MBgJzdghzajVb6Bqj+aWi59+AbyU3SIVVKJgjGIkyFerMs9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718106159; c=relaxed/simple;
	bh=ZYt9Ce6a5vvrReHnVDTq0y2clVGZm/xWSkAGdTqH350=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=QeENseVbLIJPAhrMzAPJSNvGQIQyqOb1pbwzzzvsgjCv8mfybqO08J6lvvkD5+lgbIuasAC85nbn99aAPw4Ivn/ZLog462HAWtxPZW4cDFviP8EBxbgbh3CN24yvqDsIxGWRm8Dbxzm50wVmoQ/UksCEcLxJtcpgH2oKyThXh2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=w/WNpD8j; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:Subject
	:Reply-To:Cc:To:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:
	Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=M4yhGTk/Aq3f5EgmMM+txoxBQjY0Pv36q1oxhk38U80=; t=1718106157;
	x=1718538157; b=w/WNpD8jL8xuU49Ewtl+leZ3LJFMb4uEfLU6FXz9eOlEDWu0VWgASB2ayoInF
	q827Rum9MK68CZm3jBq/fa2pGloNt0COkaPRmq8koZXMzlB+G1gHGaShx2asx+tgn0qOoWlIQliQi
	6JupgdBYpzBXTWoEwVwhEzwcH6h223VjmKPX8Jo6Qda2/prRyOLDg4ddhlwQhm2IkBL5vYWJ5em4+
	enBWTsAh2+TZXnKApjuTuCerbeD+97T4S2xyRjdifFMQCpsrfj3e8p5j2GyEZcJ7WrywJwtSYws8o
	JNBt9CUxiUUt1r+N95YhYbhCT7s4GjuZBl63QfxLXyVgsYG1BQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sGzta-0004kl-N7; Tue, 11 Jun 2024 13:42:34 +0200
Message-ID: <af575951-d884-4148-977f-a3450ceaee82@leemhuis.info>
Date: Tue, 11 Jun 2024 13:42:34 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: [regression] ac and battery readings for asus laptops (gu605) broken
 since "ACPI: EC: Install address space handler at the namespace root"
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1718106157;900dab38;
X-HE-SMSGID: 1sGzta-0004kl-N7

Hi, Thorsten here, the Linux kernel's regression tracker.

Rafael, I noticed a report about a regression in bugzilla.kernel.org
that (if I understood things correctly, which in this case I'm not
entirely sure of) appears to be caused by a change of yours:
60fa6ae6e6d09e ("ACPI: EC: Install address space handler at the
namespace root")

As many (most?) kernel developers don't keep an eye on the bug tracker,
I decided to write this mail. To quote from
https://bugzilla.kernel.org/show_bug.cgi?id=218945 :

>  VitaliiT 2024-06-07 12:43:14 UTC
> 
> Created attachment 306438 [details]
> Workaround for asus gu605
> 
> Creating this ticket to highlight a regression introduced with a fix
> proposed in https://bugzilla.kernel.org/show_bug.cgi?id=218789
>
> Actually that patch breaks ac and battery modules.
> Sysfs readings for gu605 reported:
> - that AC is always online independently if power source connected
> - battery readings are wrong: capacity always 100, voltage is always
> 5000, current is always 1000000; charge_full and charge_full_design is
> always 5000. All values are not correct.
> 
> I've updated defect 218789 with a workaround patch that makes ac and
> battery modules working again with 6.10 source tree.
> 
> Unfortunately, I can not provide correct solution since I am not acpi
> expert, but I feel that Lenovo laptop might need quirks or separate
> logic for EC initialization flow.
> 
> Additionally, not sure if it is correct to use ACPI_ROOT_OBJECT as
> acpi_handle when actual acpi_ec requested for initialization. An ACPI
> expert might need to look into this.
> 
> Here are some results of investigation:
> 
> In 218789 due to reported error proposed to use ACPI_ROOT_OBJECT which
> supposed to initalize EC's, but on asus laptops this change breaks
> backward compatibility.
> 
> So ec_install_handlers is called from acpi_ec_setup and first_ec will be
> set to ec in the beginning, so in ec_install_handlers() ACPI_ROOT_OBJECT
> will be used as handler.
>  static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device
> *device,
>                                bool call_reg)
>  {
>        acpi_handle scope_handle = ec == first_ec ? ACPI_ROOT_OBJECT :
> ec->handle;
> 
> And this method is called from acpi_ec_setup where first_ec will be set
> to ec:
> 
> static int acpi_ec_setup(struct acpi_ec *ec, struct acpi_device *device,
> bool call_reg)
> {
> 	int ret;
> 
> 	/* First EC capable of handling transactions */
> 	if (!first_ec)
> 		first_ec = ec;
> 
> I understand th> VitaliiT 2024-06-07 12:43:14 UTC
at original defect should be fixed, but preserving things
> which used to work should be also priority.
> 
> Please let me know if additional information is needed.
> 
> The fix which just works (probably it is not "proper" fix, but that
> patch makes asus battery and ac modules working as supposed to).

See the ticket for more details. Note, you have to use bugzilla to reach
the reporter, as I sadly[1] can not CCed them in mails like this.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

[1] because bugzilla.kernel.org tells users upon registration their
"email address will never be displayed to logged out users"

P.S.: let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: 60fa6ae6e6d09e
#regzbot title: ACPI: EC: ac and battery readings for asus laptops
(gu605) broken
#regzbot from: VitaliiT
#regzbot duplicate: https://bugzilla.kernel.org/show_bug.cgi?id=218945
#regzbot ignore-activity

