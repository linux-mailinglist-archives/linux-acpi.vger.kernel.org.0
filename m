Return-Path: <linux-acpi+bounces-5908-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 686F18CAB5F
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 12:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 669731C21538
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 10:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A434206E;
	Tue, 21 May 2024 10:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="vc7D2ADM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18AE6A8AD;
	Tue, 21 May 2024 10:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716285689; cv=none; b=jqBtiGstXpFuK2jm8o7qHxFSyME1vpfeGzu8hJzcOf32dCEm6NKPvBS8UU+k1qlkg0GuEuE6ksP3JfnzXxY7c50AKZLnh0Ak7rUS6C6rtudhhpUTQaX5qoUpMLMCMpvgmwTSge8WQTmMiIXdyCu6Swu5iT4rjRoq9g43eRk1py8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716285689; c=relaxed/simple;
	bh=n8+o3NVnL57asI8p4M/36TOmWj7QNAqCHYBIEm6XABA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CjikhbNzy6UEX5nrM0WPSJueA3MRy2U+dEmDp31eo7iaoOPxY8HMW692nvIoGWwKsmEQ/lwfLAx0oUuH3t1Ye33pIVcg2UEsPflKmWiDoOzX33deqQPZPmcvI2TjOqid4fcijVk9cgq01okws1POFyDMLRUGrzpNI0LjMmvllIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=vc7D2ADM; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=j75BGBZI1XcWKMkzeEf52Hy2BMGSWC5SHXSgriK1ehQ=;
	t=1716285688; x=1716717688; b=vc7D2ADMAp/nMoHfrkYJjjr00DE67wlW7XHbaK4S8r6U5yH
	dfK8Cdna3KtqnWE5l7Fw+LJ2wfb5LJhehJ8vaWQpbZvoCaSrnCM4282CxGesNrlmVy89gb6mHoSZp
	3wsMC6deVsKvs5kY+ut+3s85J0oa6V7TRSd2iKNHwCVfloijByOmH9Al8SKiLI5apoX9aK7X6PPdY
	zwbF/4pna8g9ZKoABiQXvlM/PfG7f1ttHehgjmUw8N2EwCpJNq35+VHMSP93Sk9e6w5535gk3Rh8T
	g0Yn9NQte1OmaS78fjNMxqec0arpAcDVpJBgpToxlOgEtlts4fc8Kl1bbeercsrA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1s9MJ3-0000k3-Uj; Tue, 21 May 2024 12:01:18 +0200
Message-ID: <b20b567f-ce96-45e8-aab7-29768f8313f5@leemhuis.info>
Date: Tue, 21 May 2024 12:01:17 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH] gpiolib: acpi: Move ACPI device NULL check to
 acpi_can_fallback_to_crs()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Laura Nao <laura.nao@collabora.com>
Cc: mika.westerberg@linux.intel.com, linus.walleij@linaro.org, brgl@bgdev.pl,
 kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "kernelci.org bot" <bot@kernelci.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20240513095610.216668-1-laura.nao@collabora.com>
 <ZkHlLLLoagsYlll7@smile.fi.intel.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <ZkHlLLLoagsYlll7@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1716285688;572a1b2c;
X-HE-SMSGID: 1s9MJ3-0000k3-Uj



On 13.05.24 12:02, Andy Shevchenko wrote:
> On Mon, May 13, 2024 at 11:56:10AM +0200, Laura Nao wrote:
>> Following the relocation of the function call outside of
>> __acpi_find_gpio(), move the ACPI device NULL check to
>> acpi_can_fallback_to_crs().
> 
> Thank you, I'll add this to my tree as we have already the release happened.
> I will be available after v6.10-rc1 is out.

Hmm, what exactly do you mean with that? It sounds as you only want to
add this to the tree once -rc1 is out -- which seems likely at this
point, as that patch is not yet in -next. If that's the case allow me to
ask: why? I'd say it should be fixes rather sooner than later, as other
people might run into this as well and then have to deal with bisecing,
reporting, ...

Ciao, Thorsten


