Return-Path: <linux-acpi+bounces-16698-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 363ABB543FC
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 09:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B27687A807D
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 07:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7632C21F6;
	Fri, 12 Sep 2025 07:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="XVgCvI9W"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8C425F96D;
	Fri, 12 Sep 2025 07:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757662487; cv=none; b=hKkqPXdcQwXy8/ORRcxyexmedoa87WWlj8MpZbjGETmb+04FKFd6tnTnzGnzP/IGhpcR/cPCXT12vrqL/IR99QtLP2JSHC4n5NczK7rXZ+Lry73BiiG0NC5pMeakStaP7uhXWVWA4HFO9OiEDEpUsVslBnX87WeQTpoesrpzFdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757662487; c=relaxed/simple;
	bh=BEYoB3XdJvkU8n8LcEWV2oTAdVLiA1j459GZpHGv4FM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=r4vYxk5c5UYvZNM2bI3dl5GRIV+bMuQZ+fJxbPfmg97Eu0Rg7lFya/7TfWJPjMrPgLaVPaesgbuy4R17s2hiw3mOMoxIgrlRrfF/iiVoYNXf4RE2xl8HEgC7LdK0i3Utt74+tmqRQs5QSlLrU7RBcW1C6stW/tVoDl3W5SHzH1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=XVgCvI9W; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757662438; x=1758267238; i=markus.elfring@web.de;
	bh=MscxGB98VFXuPCr9hE7EAg+kk5OTN4rOo+anFsMbFV4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XVgCvI9WUvBgHJqmgpANa9paASrfxvqaTaOFuoM3VL1IBR6Jz8y2D8mHR4N2uzDa
	 pR1yBYLgE3XStEv/vYg2HANlwDyuHkYB6H9289Wbm/AUxHHGdt+gTk9Ub2ZAu1kVI
	 Ov7ZqTgBUKCr0olwc+p+SPdzglD7IwY9qMcK+aHJ870wOkHyIXh2XParY9JkUYOAd
	 w4xHrLUqR4LbYGOARObz1hp86ujjLfnOgyRdR/C3zKFiI/NTaXcWYZ/okILYWZcsc
	 MPjGDNGjIJu3pY3F65LPTijmWrMIulzVtOS0g/bcvInIy/zITNkwTOsp23hNiMfin
	 oQYOvNxLf/Usmcy6/Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.219]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7Nmo-1v4fvt38Gq-005DkR; Fri, 12
 Sep 2025 09:33:57 +0200
Message-ID: <323c362f-9cdb-47f1-834a-b3ee4bb04c32@web.de>
Date: Fri, 12 Sep 2025 09:33:50 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: James Morse <james.morse@arm.com>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Amit Singh Tomar <amitsinght@marvell.com>,
 Baisheng Gao <baisheng.gao@unisoc.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Ben Horgan
 <ben.horgan@arm.com>, Carl Worth <carl@os.amperecomputing.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 D Scott Phillips <scott@os.amperecomputing.com>,
 Danilo Krummrich <dakr@kernel.org>, Dave Martin <Dave.Martin@arm.com>,
 David Hildenbrand <david@redhat.com>, Drew Fustini <dfustini@baylibre.com>,
 Fenghua Yu <fenghuay@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hanjun Guo <guohanjun@huawei.com>, Jamie Iles <quic_jiles@quicinc.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Koba Ko <kobak@nvidia.com>,
 Len Brown <lenb@kernel.org>, Linu Cherian <lcherian@marvell.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Peter Newman <peternewman@google.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
 Rohit Mathew <rohit.mathew@arm.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>,
 Shaopeng Tan <tan.shaopeng@fujitsu.com>, Sudeep Holla
 <sudeep.holla@arm.com>, Wang ShaoBo <bobo.shaobowang@huawei.com>,
 Will Deacon <will@kernel.org>, Xin Hao <xhao@linux.alibaba.com>
References: <20250910204309.20751-10-james.morse@arm.com>
Subject: Re: [PATCH v2 09/29] arm_mpam: Add MPAM MSC register layout
 definitions
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250910204309.20751-10-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5ZzuGnnBIl96e5qkVvluimVHXwMQ3UGMOOz+NEg7m8xWaBk8rQK
 T1+ehFgrgACSD1OAdvRnLcOyl0orXb44idS5/psmS0ptDfe1kuebhPzxqBJoVW/EL4YRk53
 TOdp16qPXKMaSme41m9X5RXN1Ifovs4gkLm8S/emgt13jnlAGSynJbZyjuaLCDlcFvsQP/M
 8Jx/EKbZQt9wiXcpZvbqg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YUhwx+D9k+E=;7cxxjEtKjiHhr9gDsjsoNm93k7L
 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
 NWmSlpfmHhqgUKSM=

=E2=80=A6
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -152,4 +152,271 @@ extern struct list_head mpam_classes;
=E2=80=A6
> +/* Error conditions in accessing memory mapped registers */
> +#define MPAM_ERRCODE_NONE			0
> +#define MPAM_ERRCODE_PARTID_SEL_RANGE		1
=E2=80=A6
> +#define MPAM_ERRCODE_UNEXPECTED_INTERNAL	7
=E2=80=A6

How do you think about to use an enumeration for such a value collection?
(Is there a need to extend implementation details in similar ways
at further source code places?)

Regards,
Markus

