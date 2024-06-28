Return-Path: <linux-acpi+bounces-6658-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC9791B570
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Jun 2024 05:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBC881C217E6
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Jun 2024 03:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E631CA8A;
	Fri, 28 Jun 2024 03:27:35 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D8117583
	for <linux-acpi@vger.kernel.org>; Fri, 28 Jun 2024 03:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719545255; cv=none; b=TkGIFioYecfPUNW5yuxZwzz1Peq/JvjTfI/LknnqjEVMsj+n65zRn/LDtLmmuONB/Rsphz+/+NzKIemInLnjfftOZv0KSBAl6GD3IGY2jeTk6veJEr7DoRY/2CLCqPaBN02HLA3NTcP2E6SRelhtbCjCAe5Ob6e032kHce1a96c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719545255; c=relaxed/simple;
	bh=a3olSj8nVDgW4q/EBPpehEZzXrNx6E2BpkN/BcooknI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HmQakiCcVzhduNSxzGNTAezYZ80kyDqsQ0hS4oN45lEwV7wmtxxleWIc7ib/dxQkVC4y7BfLfvm+ajsNhUp9StioZPXj/ueRGluqTTrOXxBNq9/dOfT3Fl+Q0ulgip/utO48zak2UY66vj/Wa8rV+xkTe80XCx2FOMshP1Si3bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1719545240-086e231108138f50001-I98ny2
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx1.zhaoxin.com with ESMTP id tbdnvh16gC4lZJdo (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Fri, 28 Jun 2024 11:27:20 +0800 (CST)
X-Barracuda-Envelope-From: LindaChai@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Jun
 2024 11:27:20 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Jun
 2024 11:27:19 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from zxbjmbx1.zhaoxin.com ([fe80::2c4a:ac53:52a8:1a13]) by
 zxbjmbx1.zhaoxin.com ([fe80::2c4a:ac53:52a8:1a13%3]) with mapi id
 15.01.2507.039; Fri, 28 Jun 2024 11:27:19 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.163
From: "Linda Chai(BJ-RD)" <LindaChai@zhaoxin.com>
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
CC: "Cobe Chen(BJ-RD)" <CobeChen@zhaoxin.com>, LeoLiu-oc
	<LeoLiu-oc@zhaoxin.com>, "Linda Chai(BJ-RD)" <LindaChai@zhaoxin.com>, "Tim
 Guo(BJ-RD)" <TimGuo@zhaoxin.com>, "acpica-devel@lists.linux.dev"
	<acpica-devel@lists.linux.dev>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "j.granados@samsung.com" <j.granados@samsung.com>,
	"lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "mcgrof@kernel.org" <mcgrof@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"ricardo.neri-calderon@linux.intel.com"
	<ricardo.neri-calderon@linux.intel.com>, "robert.moore@intel.com"
	<robert.moore@intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH 3/3] ACPI: cpufreq: Add ITMT support when CPPC enabled for
 Zhaoxin CPUs
Thread-Topic: Re: [PATCH 3/3] ACPI: cpufreq: Add ITMT support when CPPC
 enabled for Zhaoxin CPUs
X-ASG-Orig-Subj: Re: [PATCH 3/3] ACPI: cpufreq: Add ITMT support when CPPC enabled for
 Zhaoxin CPUs
Thread-Index: AdrJCJizLp8Sv9dXStirpjor4h554A==
Date: Fri, 28 Jun 2024 03:27:19 +0000
Message-ID: <4bee9e6ac2c84311ad7f7654d398f62a@zhaoxin.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1719545240
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 574
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -1.99
X-Barracuda-Spam-Status: No, SCORE=-1.99 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=BSF_SC0_SA_TO_FROM_DOMAIN_MATCH, THREAD_INDEX, THREAD_TOPIC
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.126861
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.01 THREAD_INDEX           thread-index: AcO7Y8iR61tzADqsRmmc5wNiFHEOig==
	0.01 THREAD_TOPIC           Thread-Topic: ...(Japanese Subject)...
	0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH Sender Domain Matches Recipient
	                           Domain

SGmjrEFsbA0KSSBoYXZlbid0IHJlY2VpdmVkIGFueSByZXBseSBhYm91dCB0aGlzIG1haWwgZm9y
IGEgbG9uZyB0aW1lLiBJIGRvdWJ0IGlmIHlvdSBoYXZlIG5vdGljZWQgaXQ/DQpJIHJlYWxseSBs
b29rIGZvcndhcmQgdG8gcmVjZWl2aW5nIHlvdXIgc3VnZ2VzdGlvbiBhYm91dCB0aGlzIG5ldyBw
YXRjaC4NCg0KQlJzDQpMaW5kYQ0KDQoNCrGjw9zJ+cP3o7oNCrG+08q8/rqs09Cxo8Pcu/LXqNPQ
0MXPoqOsvfa5qda4tqjK1bz+yMvKudPDoaPRz737ttSxvtPKvP678sbkxNrI3df2yM66zs60vq3K
2siotcSy6dTEoaLKudPDoaK4tNbGu/LXqreioaMNCkNPTkZJREVOVElBTCBOT1RFOg0KVGhpcyBl
bWFpbCBjb250YWlucyBjb25maWRlbnRpYWwgb3IgbGVnYWxseSBwcml2aWxlZ2VkIGluZm9ybWF0
aW9uIGFuZCBpcyBmb3IgdGhlIHNvbGUgdXNlIG9mIGl0cyBpbnRlbmRlZCByZWNpcGllbnQuIEFu
eSB1bmF1dGhvcml6ZWQgcmV2aWV3LCB1c2UsIGNvcHlpbmcgb3IgZm9yd2FyZGluZyBvZiB0aGlz
IGVtYWlsIG9yIHRoZSBjb250ZW50IG9mIHRoaXMgZW1haWwgaXMgc3RyaWN0bHkgcHJvaGliaXRl
ZC4NCg==

