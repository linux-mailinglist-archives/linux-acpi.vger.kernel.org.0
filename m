Return-Path: <linux-acpi+bounces-17364-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8397BA4DCA
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 20:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D3CC740070
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 18:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A15D1C7013;
	Fri, 26 Sep 2025 18:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="UjjSGDmK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55F01D7E31;
	Fri, 26 Sep 2025 18:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758910579; cv=none; b=uBoTeAegmM2ulunU/sZIBCU02J2AV2EWtskxpUHWPUCsSBdMBxNPb0RAvuC0nENdosU3jCTMABYffd3CVRvWT8Yzs0u3NHXaDcvs09Vq0o4b7IQ74fzfollfhtIOU3cnz934SLUNsD+2W3dVrEhLUUbOb5Zo1oTEgjLhWZ+w3T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758910579; c=relaxed/simple;
	bh=CP15thKib2R8+k5xSriEGbfQdYizPZTAvRCg91KReCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c521evfoeBvOQxymZe/iUV5aoZtuCZ8w+tLwf6VX7UvsoOVpMngBD3W6yI0Ow9wYwySesHdJomGRvFBMRNXFIq2ZLGDz3uYbAh90/xwGYlrveM7n5FCItqxGKQQUbVkQR2FrvbpVKqwDRi8mjmxddtY/CyRom+BM8hAgjNSspmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=UjjSGDmK; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1758910567; x=1759515367; i=markus.elfring@web.de;
	bh=E7bujOx4DLPqZWlI88EeoZQECVrnfxfxTKQOIZYfXFk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UjjSGDmKMNhinqObi/9/aMnoURgOynKmAmlpClh7bd6cijbMOrAuv/pX7OTFo4hD
	 VJ6fMTZdEBQw9/HGZV8QCAiFH00ykuAvrO4FK8pfvis2LS9NZ4/MnqruNy75Co7dE
	 3BdHfaggo9amSSqkIM466kcqujKISTndRismn7MKMWv5g9DICKVv9vhSbxv+cl+Rb
	 C7/7yyy5fN88QIbejFBIKB39B4U1jTVHOQMbqsjSJSbTjGA/TpjngN7omx6692BMq
	 V18stSp1xSKbKllvOP2Xe7aHcQRafahZO6s7yFueWfl5QdJ+WovRrXbeS0d6g/10q
	 ovublZK2YBjxd6bWng==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.192]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M2xrq-1v3Iux1ocO-00HEZy; Fri, 26
 Sep 2025 20:16:07 +0200
Message-ID: <a4a637e4-ae58-40ec-a4d3-a382aaad814c@web.de>
Date: Fri, 26 Sep 2025 20:15:59 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/29] arm_mpam: Add the class and component structures
 for firmware described ris
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
 Sudeep Holla <sudeep.holla@arm.com>, Shaopeng Tan
 <tan.shaopeng@fujitsu.com>, Wang ShaoBo <bobo.shaobowang@huawei.com>,
 Will Deacon <will@kernel.org>, Xin Hao <xhao@linux.alibaba.com>
References: <20250910204309.20751-9-james.morse@arm.com>
 <5a80cb91-6095-4f44-b576-53badc4575f5@web.de>
 <88f45c7f-9769-478b-9abd-749ec8f8d43b@arm.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <88f45c7f-9769-478b-9abd-749ec8f8d43b@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3maQEK1CnO2+DU9yp6HepDChC5p4ETeKuI0ApbsfHO+X/YgS2LC
 dRzrPIgIcL1KhPZ7dv0Oa8fyvEzmUMF3LO/0E10X2ePh7UkZTEOzX4loa0dXfGdb147k1jH
 Ze60pl3hfj+dqInxRRgQkBBWCGZmNtoZcZ99tcTJX2g86Yk1DyH7ZgaFQIcd6Gu8aci7yP7
 1qxwDsznYILHFBXSEGYvg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5Isi+WWbkIM=;uYOd6aMpArFg9S1d4KDVSF55ybB
 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

>> =E2=80=A6
>>> +++ b/drivers/resctrl/mpam_devices.c
>> =E2=80=A6
>>>> +int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
>>> +		    enum mpam_class_types type, u8 class_id, int component_id)
>>> +{
>>> +	int err;
>>> +
>>> +	mutex_lock(&mpam_list_lock);
>>> +	err =3D mpam_ris_create_locked(msc, ris_idx, type, class_id,
>>> +				     component_id);
>>> +	mutex_unlock(&mpam_list_lock);
>> =E2=80=A6
>>
>> Under which circumstances would you become interested to apply a statem=
ent
>> like =E2=80=9Cguard(mutex)(&mpam_list_lock);=E2=80=9D?
>> https://elixir.bootlin.com/linux/v6.17-rc5/source/include/linux/mutex.h=
#L228
>=20
> None! The bit of this you cut out is a call to mpam_free_garbage() which=
 calls
> synchronize_srcu(). That may sleep for a while. The whole point of the d=
eferred free-ing
> is it does not happen under the lock. The 'guard' magic means the compil=
er gets to choose
> when to call unlock.

How does this feedback fit to the proposed addition of a mutex_lock()/mute=
x_unlock()
call combination (which might be achievable also with another programming =
interface)?

Regards,
Markus

