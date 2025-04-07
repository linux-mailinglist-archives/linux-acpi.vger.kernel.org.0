Return-Path: <linux-acpi+bounces-12817-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFA6A7ED28
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 21:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54DFF424633
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 19:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F30223709;
	Mon,  7 Apr 2025 19:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="Xdf9CB2d"
X-Original-To: linux-acpi@vger.kernel.org
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C61222569
	for <linux-acpi@vger.kernel.org>; Mon,  7 Apr 2025 19:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744053009; cv=none; b=Dc7bubB/cTnznvlzrpQQ9/MJXusSYN6Ad+cq8jL83i2q0fxzquQAbhlRER6Xc91rr/sVsJuq5/w5JbBCUIUGnWORoHDp1WcVNgLT35JGggsbp0UJ7PQc3YMoek8D2L6yLjK2X61egZf9Evgzkzx2KUANqKOAjt0O4JBNIB4UrYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744053009; c=relaxed/simple;
	bh=hlvX3dKMPy7AKbI9AZt2/QooFInqEXvd3/I/fL8l5fI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D5Wk0TCn3pR3wK8gfvaq6H01kwPXLCn1xyyLlxGXKvp/+Of1Lc9A1Pib4hnWB6FXmRbkorQo7Az73DrJTCQdyoYWUEJb1aO01nRAfMLXOnU5yrGZwQDp9lcMA7EWGmJKYktmGLj67gVhYOZ6nFDu93kUQsJdBw81QIecCjwd1Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=Xdf9CB2d; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
	by cmsmtp with ESMTPS
	id 1oK0un7cMXshw1rr6uFqlt; Mon, 07 Apr 2025 19:10:00 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 1rr5uYetYnOa11rr5uisAp; Mon, 07 Apr 2025 19:10:00 +0000
X-Authority-Analysis: v=2.4 cv=Z83qHmRA c=1 sm=1 tr=0 ts=67f42308
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=B3fuDwYyW55wTQKIj88FGw==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=r2MVV0ggy3cR_goCns0A:9 a=QEXdDO2ut3YA:10
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6Fx0cjpFIDP4TVvSQqu5zpeRXwbcNwQbAPGVgowUYRY=; b=Xdf9CB2dHJJGo5zpUmzK33wSBC
	oqUBtFezyXl6wHdvY7YydiHqg1RVT0c/TSV/uffAA3UEOPueeWF8wyz6L72Au/5KEqy09cdegIfvt
	npIxnP15aME7/oaENDMfM53z9se1OI337fnPiI0Hh3+0QwiM7JHlwrA5I+oxttpA0JM6UB3xbfgFN
	rC+2CFTz+ft/f3TyX8LEpexdnI3wwGu5wQpKJ4a1KnXQt9dSOxF5VZausMuHQ3BO2OPhGBsWyRarq
	dIMZDpv7P0Lv9YVo2cd+SYcVd4W0IF71SYJ5i7AThHgjwNQNxPiMatsyKhKzgOGp/W1ULUjnaLXvD
	4GXlA3yQ==;
Received: from [201.172.174.147] (port=39666 helo=[192.168.15.6])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1u1rr3-00000002JT0-2lW1;
	Mon, 07 Apr 2025 14:09:57 -0500
Message-ID: <b5ab34b1-e27a-40ca-be24-56a28b5d37bd@embeddedor.com>
Date: Mon, 7 Apr 2025 13:09:51 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] UAPI: ndctl / acpi: intel: Avoid multiple
 -Wflex-array-member-not-at-end warnings
To: Kees Cook <kees@kernel.org>, Alison Schofield <alison.schofield@intel.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, nvdimm@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <Z618ILbAR8YAvTkd@kspp> <Z65xV2TaFY32eYdp@aschofie-mobl2.lan>
 <202504071106.3A0AF875F@keescook>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202504071106.3A0AF875F@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.174.147
X-Source-L: No
X-Exim-ID: 1u1rr3-00000002JT0-2lW1
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.6]) [201.172.174.147]:39666
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGxa0gwoAseFdlet8t2dY58C58GH34+78BByFPpTcJtaCbYfIpkxGB5YwnsmOCh6qHHXobso4+DBY3JZMfWtBcEeHmf+EOd8kPvAxZFvz0oBjonxUtVf
 hjb2o9bgp8I4TlXHF7gWQSn8+0Io0OW9nbluMUHt8h0A9z2VxxSarhvvv6JSvaVGbbFglfbQiAfkZRScc7ZRS+88uhwKapLTwXde46ALEFrF5aIOi66j/vjb


> Gustavo, any updates on this patch? I'm skimming through patchwork to
> check on stalled patches...
> 

Yep, I proposed a couple of patches for this:

https://lore.kernel.org/linux-hardening/a66056cf-570c-4875-b5cf-c51e2bc488d9@intel.com/t/#mf958b73b3021db415b9e9c623c3f386259ca0829
(not sure why my patch doesn't show up on linux-hardening anymore...)

And this is the most recent alternative:
https://lore.kernel.org/linux-hardening/Z-QpUcxFCRByYcTA@kspp/

Thanks
--
Gustavo

