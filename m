Return-Path: <linux-acpi+bounces-16062-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C8FB35153
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Aug 2025 04:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FA427AE1A3
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Aug 2025 02:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518721D90DF;
	Tue, 26 Aug 2025 02:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="F9LdA+Gh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A856192D68;
	Tue, 26 Aug 2025 02:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756173738; cv=none; b=lkUo2+rBw58HMlsGSq69Yw9Laqmvm2kfnVNJSf1Opf7HqHA79f3Gkq8elsZV0dfKW+YgOIP6RshmU9Kq3vcIXBQDTTUJwCa9QcKwaAe8XDv1v11JX27O8ELkvjuzEpVclzrjKqRS1gBSsint5ZTxv52N0yTwvpPAaPRa1UBPm2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756173738; c=relaxed/simple;
	bh=JwkZ2bMQ5GCS7U8MEes6rV1TMJu1+PrRtUUNfasPYN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tb0Zngdew0ui+BhWL+F78wCeB+EE5eQxTNByfCtluM4dA1UTvFTwHDnQ+X1jBlH5wZQik5wRCsIx31hU5cDJmFjDGDxV1DmbY5+605DQNOjD1UGkkmE/ja3fniKT1jOPvlMtb88/FcxVrOeddMx71CzUEGmAftn9oOUXhOK7vIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=F9LdA+Gh; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1756173684;
	bh=x2lm0Nv/OCTl6+uM6Cq+pGjsGylnSoWqva7oGlwIzo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=F9LdA+GhG7iumMTJgssxGWUM7BmPmh8PKkT5ihdM9ZnVeIXG9/Oy6qGSSvP1keIkS
	 BwllgMPE5i0rWUx3/l9N7G8eQNGQXiic/9Z85RATHl8x1QkyMt+GMi+vwLeuiFY8FY
	 tYQ83x6lHtacHUd10+QH8kw09PSA2sYtDln09jDI=
X-QQ-mid: zesmtpgz1t1756173641t8c763dc4
X-QQ-Originating-IP: HAijc7zlmTkG2Gkix8pePMJcIs9gw8Wv0VDKqht3P1o=
Received: from [198.18.0.1] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 26 Aug 2025 10:00:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8734322752003824177
EX-QQ-RecipientCnt: 10
Message-ID: <E083185E2C999692+e1900212-490b-4637-9094-919d5df2b1a0@uniontech.com>
Date: Tue, 26 Aug 2025 10:00:39 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPICA: add more parameter validation for
 acpi_walk_namespace()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, wangyuli@uniontech.com,
 guanwentao@uniontech.com, niecheng1@uniontech.com, zhanjun@uniontech.com
References: <20250815-acpi_fix-v1-1-a05ebfe1b8ac@uniontech.com>
 <CAJZ5v0iaAgpGhtH27j0hRDF7-S9F7uHZ4GZkmbfVLQOEN+6tbg@mail.gmail.com>
Content-Language: en-US
From: Cryolitia PukNgae <cryolitia@uniontech.com>
In-Reply-To: <CAJZ5v0iaAgpGhtH27j0hRDF7-S9F7uHZ4GZkmbfVLQOEN+6tbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: Nsb+SUszp5EkDibXyUCq3QfaFL2hBySYwIBIUsXgscFZMUgrga/Lk9Zx
	EFs4D1Y5gfvyW/tf8+xk1cf3r7X0b7jdTQEj4R/b2AyItiSvH1cS5x9IZkG4K/kyjuiG6Q7
	tOAF+2r4WFKzgBFc7qlAKHSfP2zBEOpocarHK3SMNRZRTLO7krG3E5K89Upwlj2dNU+7TYI
	+yVgefil3ljpn4D4BSTv3MGK9C4Ni1hePjpOYNdGrxgpETLZktXIBIml58nu1IUSlj9Wsrs
	XnRXE0fyC5/BRC2yRDVHVgJR/2sNDKp3gwBSIxp9sVATJ25n3ytIUqXfCdBkpJmNt7kpvkB
	AU7B2rkVyafDe0CSnv2i51BFtMWDvj9WatlfInZYj1xYVBlPSPQakfKttfKqyBFOa+aSqIx
	fAL5i+KgVtyG9qisaDMHZrEkqnFDjJ8k8eNU4A+GzGfsv2Nvy8F+3keqSm2YYnAs1FWybOJ
	UWIk13lg2JEuyDZYmaBJzit10fxxFnnC2UoUBbTl/B59/rEvt0iFWRQhO7SnTT5z+9i0ANo
	0peMkj9u7jUoKh12XTu768hYeX1s6T60qPPEiCjNeVWK7xqoJfmwZbSIg5jI22tScQ97BrD
	gNLRWKzg47QPSXoXn7kDElHtVSsRDEYUBUjD9HOyXf+TZjmWjAY8zmYtDdWCAH8dxVW75N7
	wiKlMby0JtdO5WhGc6h9+mUxGKPCfizC6V8jLhg/Gocu6PKBt4QzXu9exfRmAX9irniA6X0
	/mTGaUhcpEGH1BnlJS7TQH6HeXLXStkdZNKyBeL6WPubxrkLJn5+V7xP0qwM1vFoXQf+lOT
	q+/Lnoj+V+ADPrkExbUVCA2NFFFwjF6r9oA8R07rEdhaHR92n/8vFkbo947bfb6eaC/fVJ1
	bA60vschywdfbbywQmBgkxXjkz3VoTt3HtzaH66ALbYkCHpMhaQ608h2e202FO9BSbbJKwQ
	diIc3anBl/qnOtjfLSaptZXJX7X0WsvTHI3yvFDm67Z8Xl0Trxo9Z2ltLosS7p7Qb7GlnPg
	14zyyqhk0J3xdYXQM/ZgVC5AFWUMDjoM2z53fddlDmIkL2LCUuSOew6JzcniDnpTonQH4wy
	Xgz9UmBI8EI
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0


On 25/08/2025 23.00, Rafael J. Wysocki wrote:
> On Fri, Aug 15, 2025 at 10:56 AM Cryolitia PukNgae via B4 Relay
> <devnull+cryolitia.uniontech.com@kernel.org> wrote:
>> From: Cryolitia PukNgae <cryolitia@uniontech.com>
>>
>> On the Honor FMB-P-PCB laptop, an incorrect ACPI table causes
>> sdw_intel_acpi_scan to pass a NULL pointer as start_object to
>> acpi_walk_namespace() when calling it, which eventually causes the
>> kernel to report a NULL pointer dereference[1].
>>
>> 1. https://gist.github.com/Cryolitia/a860ffc97437dcd2cd988371d5b73ed7
>>
>> Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
> Please submit ACPICA changes to the upstream ACPICA project on GitHub
> as pull requests.  Once they have been merged upstream, you can submit
> a Linux patch based on the upstream one with a pointer to the
> corresponding upstream commit.

I couldn't find which upstream file in acpica on GitHub should be 
modified, to match my kernel patch, but I found that the upstream has 
already added this parameter verification[1], although the source code 
is in a different form.


1. 
https://github.com/acpica/acpica/commit/19d0e9560c76a9f56f214f2a9f145ebd89e8ed49#diff-4e61bde9966be8a3b82956db81c0dafb02a39ae7f92c18eef5bc1d2b57d34ff7

>
> Thanks!
>
>> ---
>>   drivers/acpi/acpica/nsxfeval.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
>> index f9d059647cc52e94ce013af3382addba338820e8..c1f318ea7d5fcd846dc158b155286a6f5bba4cff 100644
>> --- a/drivers/acpi/acpica/nsxfeval.c
>> +++ b/drivers/acpi/acpica/nsxfeval.c
>> @@ -564,7 +564,7 @@ acpi_walk_namespace(acpi_object_type type,
>>
>>          /* Parameter validation */
>>
>> -       if ((type > ACPI_TYPE_LOCAL_MAX) ||
>> +       if ((type > ACPI_TYPE_LOCAL_MAX) || (start_object == NULL) ||
>>              (!max_depth) || (!descending_callback && !ascending_callback)) {
>>                  return_ACPI_STATUS(AE_BAD_PARAMETER);
>>          }
>>
>> ---
>> base-commit: 24ea63ea387714634813359e2c8e0e6c36952f73
>> change-id: 20250815-acpi_fix-3724e6c4da02
>>
>> Best regards,
>> --
>> Cryolitia PukNgae <cryolitia@uniontech.com>
>>
>>

