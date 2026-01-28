Return-Path: <linux-acpi+bounces-20697-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMYGAMJ0eWkSxQEAu9opvQ
	(envelope-from <linux-acpi+bounces-20697-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 03:30:26 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEB59C454
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 03:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC6FD301A7C0
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 02:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9200029BD95;
	Wed, 28 Jan 2026 02:30:01 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E261C238D54
	for <linux-acpi@vger.kernel.org>; Wed, 28 Jan 2026 02:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769567401; cv=none; b=iXUjpcaNov0zJh+o563Udx3il+rC6WpytjcGFAk8c7D1lhUK/vpBG1w4pF353DBfUx3Ncr4VCUQcPaj+KdFpaomxqwMkUIiJsqh385rSNDE7sYCSC1HutGUT7yTWpW7mSEU5lGqenKdx9Zm0qKvJ3RzI1BAiuRQ5R/+DzmfqDos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769567401; c=relaxed/simple;
	bh=XUeEqG909tvzy7gvkkrNu4A2sjv0GzJIZ+w0z38IObo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kC7AnpvyELhXY7NLsXeYcZ9lPG1fatEf9VQpb/JLhVmptJQ+LCF2i94aHz1f839zkMF1V74C7omtHRKkMpXLIcmnvtsRULhlsZ+139SZqgQW3hKyAHHEp7OjqsbdT0epfN1UrLrCdUQbGtOyrbvvxGTU3+AtV4V1rDVWQLYMJ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1769567386-086e2306f644d80001-I98ny2
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx1.zhaoxin.com with ESMTP id 4MDi4dmfZU2MLpQw (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Wed, 28 Jan 2026 10:29:46 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Wed, 28 Jan
 2026 10:29:46 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85]) by
 ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85%7]) with mapi id
 15.01.2507.059; Wed, 28 Jan 2026 10:29:45 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from [10.32.64.8] (10.32.64.8) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Wed, 28 Jan
 2026 10:22:01 +0800
Message-ID: <09a7b5f8-27a6-4343-a73c-ad54112d0f4c@zhaoxin.com>
Date: Wed, 28 Jan 2026 10:22:03 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apei/ghes: Add ghes_edac support for __ZX__ and _BYO_
 systems
To: Borislav Petkov <bp@alien8.de>
X-ASG-Orig-Subj: Re: [PATCH] apei/ghes: Add ghes_edac support for __ZX__ and _BYO_
 systems
CC: <rafael@kernel.org>, <tony.luck@intel.com>, <guohanjun@huawei.com>,
	<mchehab@kernel.org>, <xueshuai@linux.alibaba.com>, <lenb@kernel.org>,
	<jonathan.cameron@huawei.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<leitao@debian.org>, <fabio.m.de.francesco@linux.intel.com>,
	<jason@os.amperecomputing.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>,
	<LeoLiu-oc@zhaoxin.com>, <LyleLi@zhaoxin.com>
References: <20260126103313.6966-1-TonyWWang-oc@zhaoxin.com>
 <20260127112845.GAaXihbb0LzZQqJfBB@fat_crate.local>
Content-Language: en-US
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
In-Reply-To: <20260127112845.GAaXihbb0LzZQqJfBB@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 1/28/2026 10:29:45 AM
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1769567386
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://mx2.zhaoxin.com:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 947
X-Barracuda-BRTS-Status: 0
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.153674
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[TonyWWang-oc@zhaoxin.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,zhaoxin.com:mid,zhaoxin.com:email];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20697-lists,linux-acpi=lfdr.de];
	DMARC_NA(0.00)[zhaoxin.com];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3AEB59C454
X-Rspamd-Action: no action



On 2026/1/27 19:28, Borislav Petkov wrote:
> 
> 
> 
> On Mon, Jan 26, 2026 at 06:33:13PM +0800, Tony W Wang-oc wrote:
>> Add ghes_edac driver platform support for __ZX__ and _BYO_ systems
>> by extending the platform detection list in ghes.c
> 
> This is not "ghes_edac driver platform support" - this is forcing ghes_edac to
> be the preferred driver to load on those.
> 
Yes, you are right.

>> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
>> Signed-off-by: Lyle Li <LyleLi@zhaoxin.com>
> 
> What does that second Signed-off-by mean?
> 
Sorry, the second should be Tested-by: Lyle Li <LyleLi@zhaoxin.com>

> Looks like you need to read this:
> 
> https://kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
> 
> and the following sections.
> 
> --
> Regards/Gruss,
>      Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

