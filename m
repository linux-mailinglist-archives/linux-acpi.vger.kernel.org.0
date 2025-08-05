Return-Path: <linux-acpi+bounces-15527-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4DAB1AE3E
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Aug 2025 08:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D72A3B75E2
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Aug 2025 06:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E750C21B9FD;
	Tue,  5 Aug 2025 06:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="mzMCQQBv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E51E1A3164;
	Tue,  5 Aug 2025 06:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754375327; cv=none; b=kv4g2MhkrIUaQAnNJHYtPCZPJ62bj2G9LSnllo4FQNQXf34nvBkTJiEZT/2MjCtNbi5CraQX5txwSiXWG4LYt1nC04qCRUoM/EgfN/Y+jmKW0yTuxU05i0VWsQWsANZwsiHKut8Kx9xSXgSVCKSln7Vqr1tTARJOPIWHbLtuM2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754375327; c=relaxed/simple;
	bh=U6uDB2KwPVN9IIbqNm7yRN4lLs2O6akNystj9BTSnqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KYtBkb56Lq8UD8f/LcPW0sjlumPI3LNbprsh/TwK12zbwm4NxLbDI98NDRN1SW92CpQAY5S+vUOuCLeEKTti943eChkriab1w8ZnR6LsqRUrV6WdlccByjRDbD43LzYJUtCMrkkduaH1H5qlY5YJzIWJWe6paxbWTHFc88ZGp1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=mzMCQQBv; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754375317; x=1754980117; i=markus.elfring@web.de;
	bh=U6uDB2KwPVN9IIbqNm7yRN4lLs2O6akNystj9BTSnqI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mzMCQQBvAr046RPKx30sLlK9SVmOEOWwqC5F8MJ76beS+lcj6TITWsQ8POoLTD3l
	 GjDStTeP7ja0fMQwU2uqWjwhNjDCe9VKksO6bXYpbvZnu645FdqiC7kHVpgPmqA42
	 5cA7RUC75OS4akskDEd1MA/ddczs0GBd/b1GJe3HvoFkDac3q0+1Ni0wHa+LVChp+
	 5I2n2jxnR/sDWq92qc9lmi44GzeDsRbMLsUW5ksaxUfmJ0R7OW79c/vsFSkY8WsXB
	 TYZ4uTlF7TnAdw+LPCOOvtbNgv4hJI/3DqJrOB1ximhv9HANTDszbFoUHCb1ad9Fk
	 gwuHrrWkqciuymEEew==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.245]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MXocY-1v8X963lSG-00P3Ax; Tue, 05
 Aug 2025 08:28:36 +0200
Message-ID: <41fdbd2b-92c5-4f11-9c58-aff9b9f35e72@web.de>
Date: Tue, 5 Aug 2025 08:28:17 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mailbox: pcc: Add missed acpi_put_table() to fix
 memory leak
To: Zhen Ni <zhen.ni@easystack.cn>, linux-acpi@vger.kernel.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Jassi Brar <jassisinghbrar@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>
References: <20250804121453.75525-1-zhen.ni@easystack.cn>
 <20250805034829.168187-1-zhen.ni@easystack.cn>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250805034829.168187-1-zhen.ni@easystack.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9FnYXXZJWa+dy5fAX9zU19lrwOHDdamdfTjZDjwq5jMGFJRcoWg
 gguiDa51f35oPyEbOg/5akIOenCPhWk/Hs4zdqkW+Giy6LwU+7drkub/VIXGu2m4H2ljL3i
 UkMDqUdqgktsaRhVefLcLfhqrn2G1WAp2Z2aB4Gg29+mWcSDJH6Vkki0H+PR5ShOdKwnwjb
 6ACiqWqkiHNmzccDAmXmg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ldVu0L/C9cI=;2A+T04V5mTvOhDTc16kVP7DDm2q
 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
 QaPGYtZ20theDb2zD68VTig=

> Fixes a permanent ACPI memory leak in the success path by adding
> acpi_put_table().
> Renaming generic 'err' label to 'put_table' for clarity.

Will a desire grow for the usage of imperative mood also in such change de=
scriptions?

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.16#n94


=E2=80=A6> Changes in v4:
> - Change goto target from err to put_table.

Thanks.


> - Remove goto tatget err_nomem
=E2=80=A6

Does this adjustment indicate questionable development difficulties?

Regards,
Markus

