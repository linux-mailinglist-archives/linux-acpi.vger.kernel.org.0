Return-Path: <linux-acpi+bounces-20845-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mON/NsCmgmmVXQMAu9opvQ
	(envelope-from <linux-acpi+bounces-20845-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Feb 2026 02:54:08 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 64327E0964
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Feb 2026 02:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 83E833053946
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Feb 2026 01:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E332288522;
	Wed,  4 Feb 2026 01:54:05 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07113288514;
	Wed,  4 Feb 2026 01:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770170045; cv=none; b=Fpb55FwzuNVG/G+02l2GDtBvoFy1yrmiDWBqUOxka0VV4Pv52aup94/XmSqatiUbJ9+oKCq9dtijb+w8QcxW0mtMaXAOy3Mx+fjQSi3esUuRCT9pPNvL7uWe9OBgemaD8ZLqbyVe58wdaaR81JH9qOhMtEsPa2JKsFHtCPVf1H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770170045; c=relaxed/simple;
	bh=0XZlYn8PG+Zbg5Afwo2O8zoO6C63O9eLFK+VMtWOIb0=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZsyvvgJjKfnrG9JJd020dB2iii3WJfMjGEmwX45u0pLaXHSLgdo2ciqHsKu+NcBVSAzqSGGqPwLliLmDv+bFYKZ+lYDwaX/LDl/dCA1fTW6lQEuidFBiatm6qsHCytWp5anNG0B+0MKotZG7Ym9KqHyJrAnXFxoOMS7NXG16q3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas2t1770169980t249t33034
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.20.47.234])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 13740438715528810847
To: "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: "'Tony Luck'" <tony.luck@intel.com>,
	"'Borislav Petkov'" <bp@alien8.de>,
	"'Hanjun Guo'" <guohanjun@huawei.com>,
	"'Mauro Carvalho Chehab'" <mchehab@kernel.org>,
	"'Shuai Xue'" <xueshuai@linux.alibaba.com>,
	"'Len Brown'" <lenb@kernel.org>,
	"'Shiju Jose'" <shiju.jose@huawei.com>,
	"'Bjorn Helgaas'" <bhelgaas@google.com>,
	<linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	"'Tony Luck'" <tony.luck@intel.com>,
	"'Borislav Petkov'" <bp@alien8.de>,
	"'Hanjun Guo'" <guohanjun@huawei.com>,
	"'Mauro Carvalho Chehab'" <mchehab@kernel.org>,
	"'Shuai Xue'" <xueshuai@linux.alibaba.com>,
	"'Len Brown'" <lenb@kernel.org>,
	"'Shiju Jose'" <shiju.jose@huawei.com>,
	"'Bjorn Helgaas'" <bhelgaas@google.com>,
	<linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <23A877C77DF26B7C+20260203021233.8178-1-jiawenwu@trustnetic.com> <CAJZ5v0i4ds3Cjc5x+Umx2m57ebf4w_MOf1saE=iEFrqsv5ZrQA@mail.gmail.com>
In-Reply-To: <CAJZ5v0i4ds3Cjc5x+Umx2m57ebf4w_MOf1saE=iEFrqsv5ZrQA@mail.gmail.com>
Subject: RE: [PATCH] ACPI: APEI: Avoid NULL pointer dereference in ghes_estatus_pool_region_free
Date: Wed, 4 Feb 2026 09:52:59 +0800
Message-ID: <06ec01dc9578$fd562e50$f8028af0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQE9K3vYaHmeYxNAkoCsjOkoiT1IGQJ42lk4tpzSo/A=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Nuk8bQLQf5MZPaIHenYz0XGGRoA1LZp6vkVSLOLIqDYeMv401sZssAn2
	YyMHTdaB0gHUTlFi2BFHFPwjZ4JFBZS4xcCjL4VwKRJjjjfkmsxFuV5aDElmzv7NeNo3M6M
	mMimiarW+FExnxxs1ZbuFTHhsElqBcoAeBjImHpeDtD1fZ2kRar09+W6taDRH6TrJzA8zrI
	bLGxhcsZZl+S6VlK99lsilnWD8/uCyePAh8ToIPJIAGCj4xYXyCzZuhNXB+fZEAkbzx+R0A
	lRRI2YwrsPc9ZmbT+7+tnQiKEmpZ8tzb9RImqz9FYkbVz0UwpEtiCyaYIX0/Vt7g+3QEx7v
	MJGte6VF7YwtKDgNcPZEM5ahb5q/dBUfg5KEuFWUlE0LhnR78jSfA+tRheelQ/phGUiks+A
	h2iw9A5EUwsYs6dUx/awgXW2EbkoD0LFuL7saynDDRm6EgScwNEWMTPIMUXz+6hj5tr23Vu
	HEIMhVSQrhWcdhNBC7U732C6uzURM1sO8UvUy6/HDhabBv2yxW8QeIf9g3rlAhFO1luG/BU
	CUZDabW1agdJ3Q18/aDz+xPoMK6mY16a8DWdx8UYASVlFyevpf7h3YA9kGIU+04CdaayFB+
	Wk5DyFtuBTSX5mwByESCfNukNCYjLoeUxeFmZMh5sQAhLy6H18Vd4TM+4TaUj08KATAp7Q1
	pK7lz/jVzgD8wkURGsG8S68eWmkP15/wI70/tFlJ6jKXYcQ9ALSmW7No9HqlLr+FELhsNWT
	Md/Q7M6wwJumZPR265dRTP5Og9G40i6V2AfVhK2pfC8q9L2tC6MmbEohlfw6n+TK/7d91pR
	pWHGnidp7Q5ir6QgiC5XK0iKLMEgyurzFb0b1WhwMJfZFLoiBM1Nd+LCE3odmVkMsXinMfP
	hpDw5lGOnMmlOiPv+86+ZDpaFZ2elvNWjLAL6wRlEG5luxkNzhtbuY4wbZPUl1jVxzMu8+u
	57dNa/a7tIu8iE9F3VmXPnWFwLOwJbfbZTTVt7c28wQl8D8HMmFXW8d9+9SyY+tlp8fhuoi
	4m99iox+Bb2mrQY42Q
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	FROM_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20845-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.983];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 64327E0964
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 8:57 PM, Rafael J. Wysocki wrote:
> On Tue, Feb 3, 2026 at 3:14=E2=80=AFAM Jiawen Wu =
<jiawenwu@trustnetic.com> wrote:
> >
> > The function ghes_estatus_pool_region_free() is exported and be =
called
> > by the PCIe AER recovery path, which unconditionally invokes it to =
free
> > aer_capability_regs memory.
> >
> > Although current AER usage assumes memory comes from the GHES pool,
> > robustness requires guarding against pool unavailability. Add a NULL =
check
> > before calling gen_pool_free() to prevent crashes when the pool is =
not
> > initialized. This also makes the API safer for potential future use =
by
> > non-GHES callers.
>=20
> Are any such callers going to be added any time soon?

Yes, I want a ethernet driver to call aer_recover_queue().

>=20
> > Fixes: e2abc47a5a1a ("ACPI: APEI: Fix AER info corruption when error =
status data has multiple sections")
>=20
> It doesn't fix anything, the lack of the check is not an error
> currently, AFAICS.

So far, it seems.

=20


