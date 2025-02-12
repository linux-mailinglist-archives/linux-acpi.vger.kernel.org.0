Return-Path: <linux-acpi+bounces-11125-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 301C7A32C9C
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 17:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B42A3A3EB2
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 16:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056D5256C74;
	Wed, 12 Feb 2025 16:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="chqsZ11b"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DDE256C83;
	Wed, 12 Feb 2025 16:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379434; cv=none; b=HYbFN/R38v5PxTSFoRDkzk4m7SpZAyQiS/gjWHWzrkFAkA9o+fYdsG0ZUnPyRqpx3LRpKSRbXl96S4W5X0BRr7YkrFQO3LQ12U5XibU0RymgzQemMh49ZiYodQEn1e3RfgG1P4Up+ZboGwhX/yJii5JXiRK2L+KpSOLmCcekbLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379434; c=relaxed/simple;
	bh=fR1t7CeXF+FlrrMDmgJROQWMLPPn+T4BEP4V6XerrzI=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=rCF7i24J8nEvlnxKUgJaBeqIRZ01BvdmRD5If5DVM1m1pCe1FoUxGl2f6Kk6V+E0ooXTQPFZp1JA0RH+S3OC3MJw6bQIkN6hjBgxEx11f1NOqmPbz33H53kKErcV3PN5scrjJCErkQ2EQpdcoTON0n61Fn646icXzG7o/Fpk3Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=chqsZ11b; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739379434; x=1770915434;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=fR1t7CeXF+FlrrMDmgJROQWMLPPn+T4BEP4V6XerrzI=;
  b=chqsZ11bhTkhdtxwEJNUlkTNluoZc8uoUp/bvrWSd6GquNkOWc/jWphq
   v4BfupRtNnffaNNTSZk1/CJsb1v3bpMUtECZ/cLExAOelhVkLa1dvO79c
   xLcHbTuMv1S9xUoRwvVLnmyiRDHf3TBuHBxvx1jbLtRw2yrhqaQQeoXzv
   nxVui7DPK6Dyj/thM3g3hhq2BCEQmSiKh6VN3s/lL8qkDoBqEoxS4ilcm
   7MIytNuiUCT5uPdI9cOlRpSz0I5l9Y7aIhTLZlUOHd3Sx9Sjus7A5srFH
   y/LY0UCOK2PUyb7+dHoty1zm2PdZP3COwWw6FLM9uZHEX+MdagGNx34Nn
   A==;
X-CSE-ConnectionGUID: YTcLGtYzRIOKlykPv6nVAw==
X-CSE-MsgGUID: RI/aYVYQTCGuZpHot3Tqag==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="39972455"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="39972455"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 08:57:13 -0800
X-CSE-ConnectionGUID: Mq53iWY3QyWA26KfNoVz4g==
X-CSE-MsgGUID: rRQCDfuRSi6MbbZZMdw9OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="117882904"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.108.131]) ([10.125.108.131])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 08:57:12 -0800
Content-Type: multipart/mixed; boundary="------------BhJCh6KKkL052rdWpL6DiAAA"
Message-ID: <78895061-6f1e-4d3b-9481-95f47f97ab96@intel.com>
Date: Wed, 12 Feb 2025 08:57:12 -0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/17] hwmon: Fix Intel Family-model checks to include
 extended Families
To: "Zhang, Rui" <rui.zhang@intel.com>, "Mehta, Sohil"
 <sohil.mehta@intel.com>, "Luck, Tony" <tony.luck@intel.com>,
 "x86@kernel.org" <x86@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
 "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
 "luto@kernel.org" <luto@kernel.org>,
 "david.laight.linux@gmail.com" <david.laight.linux@gmail.com>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "Hunter, Adrian" <adrian.hunter@intel.com>,
 "jdelvare@suse.com" <jdelvare@suse.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "irogers@google.com" <irogers@google.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "linux@roeck-us.net" <linux@roeck-us.net>, "lenb@kernel.org"
 <lenb@kernel.org>, "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
 "hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
 <peterz@infradead.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "bp@alien8.de" <bp@alien8.de>, "acme@kernel.org" <acme@kernel.org>,
 "rafael@kernel.org" <rafael@kernel.org>, "jolsa@kernel.org"
 <jolsa@kernel.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>
References: <20250211194407.2577252-1-sohil.mehta@intel.com>
 <20250211194407.2577252-8-sohil.mehta@intel.com>
 <23e24c79-96ca-45da-832b-83a9b6456208@intel.com>
 <882357df-7600-4aee-9fb1-4a118872f1af@intel.com>
 <273b9080d42bcd2fb36fc4510416f0e111edee62.camel@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <273b9080d42bcd2fb36fc4510416f0e111edee62.camel@intel.com>

This is a multi-part message in MIME format.
--------------BhJCh6KKkL052rdWpL6DiAAA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/25 05:43, Zhang, Rui wrote:
> I agree.
> adjust_tjmax() contains a list of quirks based on PCI-
> ID/x86_vendor_id/x86_model/x86_stepping. The common problem is that all
> the quirks are for Fam6 processors but the family id is not checked. So
> the fix is sufficient. In fact, I think it is better to move the check
> to the very beginning of adjust_tjmax().

Or, heck, just remove the model list. dev_warn_once() if the rdmsr
fails. Who cares about one more line in dmesg?

Why not do the attached patch?
--------------BhJCh6KKkL052rdWpL6DiAAA
Content-Type: text/x-patch; charset=UTF-8; name="coretemp-1.patch"
Content-Disposition: attachment; filename="coretemp-1.patch"
Content-Transfer-Encoding: base64

CgotLS0KCiBiL2RyaXZlcnMvaHdtb24vY29yZXRlbXAuYyB8ICAgMTUgKy0tLS0tLS0tLS0t
LS0tCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDE0IGRlbGV0aW9ucygtKQoK
ZGlmZiAtcHVOIGRyaXZlcnMvaHdtb24vY29yZXRlbXAuY35jb3JldGVtcC0xIGRyaXZlcnMv
aHdtb24vY29yZXRlbXAuYwotLS0gYS9kcml2ZXJzL2h3bW9uL2NvcmV0ZW1wLmN+Y29yZXRl
bXAtMQkyMDI1LTAyLTEyIDA4OjUyOjQ4Ljc4MjczMTIyNiAtMDgwMAorKysgYi9kcml2ZXJz
L2h3bW9uL2NvcmV0ZW1wLmMJMjAyNS0wMi0xMiAwODo1Mzo0My44Njc2MTc1MDUgLTA4MDAK
QEAgLTI1OCwxOCArMjU4LDYgQEAgc3RhdGljIGludCBhZGp1c3RfdGptYXgoc3RydWN0IGNw
dWluZm9feAogCXJldHVybiB0am1heDsKIH0KIAotc3RhdGljIGJvb2wgY3B1X2hhc190am1h
eChzdHJ1Y3QgY3B1aW5mb194ODYgKmMpCi17Ci0JdTggbW9kZWwgPSBjLT54ODZfbW9kZWw7
Ci0KLQlyZXR1cm4gbW9kZWwgPiAweGUgJiYKLQkgICAgICAgbW9kZWwgIT0gMHgxYyAmJgot
CSAgICAgICBtb2RlbCAhPSAweDI2ICYmCi0JICAgICAgIG1vZGVsICE9IDB4MjcgJiYKLQkg
ICAgICAgbW9kZWwgIT0gMHgzNSAmJgotCSAgICAgICBtb2RlbCAhPSAweDM2OwotfQotCiBz
dGF0aWMgaW50IGdldF90am1heChzdHJ1Y3QgdGVtcF9kYXRhICp0ZGF0YSwgc3RydWN0IGRl
dmljZSAqZGV2KQogewogCXN0cnVjdCBjcHVpbmZvX3g4NiAqYyA9ICZjcHVfZGF0YSh0ZGF0
YS0+Y3B1KTsKQEAgLTI4Nyw4ICsyNzUsNyBAQCBzdGF0aWMgaW50IGdldF90am1heChzdHJ1
Y3QgdGVtcF9kYXRhICp0CiAJICovCiAJZXJyID0gcmRtc3Jfc2FmZV9vbl9jcHUodGRhdGEt
PmNwdSwgTVNSX0lBMzJfVEVNUEVSQVRVUkVfVEFSR0VULCAmZWF4LCAmZWR4KTsKIAlpZiAo
ZXJyKSB7Ci0JCWlmIChjcHVfaGFzX3RqbWF4KGMpKQotCQkJZGV2X3dhcm4oZGV2LCAiVW5h
YmxlIHRvIHJlYWQgVGpNYXggZnJvbSBDUFUgJXVcbiIsIHRkYXRhLT5jcHUpOworCQlkZXZf
d2Fybl9vbmNlKGRldiwgIlVuYWJsZSB0byByZWFkIFRqTWF4IGZyb20gQ1BVICV1XG4iLCB0
ZGF0YS0+Y3B1KTsKIAl9IGVsc2UgewogCQl2YWwgPSAoZWF4ID4+IDE2KSAmIDB4ZmY7CiAJ
CWlmICh2YWwpCl8K

--------------BhJCh6KKkL052rdWpL6DiAAA--

