Return-Path: <linux-acpi+bounces-18262-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC33BC1163D
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Oct 2025 21:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41C784E70F2
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Oct 2025 20:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE80A2E6106;
	Mon, 27 Oct 2025 20:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="FPCn5u3N"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A62A23EAA5;
	Mon, 27 Oct 2025 20:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761596922; cv=none; b=Xz74eFjeZljukXfZjf0SOPH1frrnUFR+LdD6j0FOad2t+USkjSX76LmJMS7zRsUFh3eKF4rqoG8Vuv7zSfzgP1QA164VYniuaQAnJcNuaoyRmpU0N3rXGQD1EFuCYpvQvdXtz0Yi3eUof+QiEGoIxucSHYrZCxMM11BzQbE2+ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761596922; c=relaxed/simple;
	bh=zQEIWpHMSH+f5Ax2uR+nfun2JlnDxtfTc14ACyoISTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B86wdToNCGozOuhMSMNLSAJwHAJ3ghmtgCBAJEn3WyI4n8wYciiN8l0RO8xofd9z3JtGv87gpoo8z4jp/iZQDlej/LPhAkghEh2Sj7xE4KF4ZP7OTemWaHXB5DPUl9e2DuyzDeVJFP3ONrq6Ym+psLU6GbEY/j9F1I0GKhEOYEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=FPCn5u3N; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1761596918; x=1762201718; i=w_armin@gmx.de;
	bh=FboM6Fhptc88Ayll92se+MUa1m/THRek9F4wTlgqnaQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FPCn5u3Nn+eRKmmETxN74M3cOdvKYztyLHoqlDviPTmk3OOGPMClwppdI6P0DwDq
	 Ghq4eH84Z3ULBMM4QQnr0iZZoxO5vhPYNIdKFv+3SiTsvQueVU0RbZbULn+yJoDLx
	 w1koJ9sldIbhawsxnMbEH+L1g3s69YIOFPcBnODJ6P+PfZSQd8RDgyWdCxcY+/hFN
	 qoA0OpIRnI4UCytObkYI6D4WukCz+7TlO77R8RAnC4Ey6I5UrIkLId0i8s1IV4bDH
	 y9CB74RfkEUL0PaaACql5wj9l6Q55NZXBQJm/zVl1rOcf2uA5GTin9gAAcezgqKk5
	 2TlhbTCgA6skNgk5Og==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1wlv-1uBFBn1UMb-0179Vn; Mon, 27
 Oct 2025 21:28:38 +0100
Message-ID: <b90f5014-85b1-48a3-8dd4-e8216e129c9b@gmx.de>
Date: Mon, 27 Oct 2025 21:28:37 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] ACPI fan _DSM support
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251024183824.5656-1-W_Armin@gmx.de>
 <CAJZ5v0juvqnn0A7pwpijhWkLDZB8U31T3J96a_Cr_RPN8C88iw@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAJZ5v0juvqnn0A7pwpijhWkLDZB8U31T3J96a_Cr_RPN8C88iw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y/zL2oJ6nb3Jw2bQOAhZnZ/HGgEukUh9nkXXHiRZUWJk7Pryc6S
 FCg/GHx53yZ3YkglfNvvJAngQw88WmEVCBmIXm4vLhG3/EuRVcpHvnLzziKYL/Uow9Wq5in
 cIlx/qcfJRFrpOjBh5TTtZ4IN02edeSUwexaeei/DLKboVz2ROGNe+jG83F+0CzpAPiilDj
 3ZztkNXAQfctWhzVO8CNw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tf7Zh6bVwb8=;inLP5nv6chxlnueEvmfvCm5ZOHq
 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

Am 27.10.25 um 20:58 schrieb Rafael J. Wysocki:

> On Fri, Oct 24, 2025 at 8:38=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrot=
e:
>> Microsoft has designed a _DSM interface for the ACPI fan device [1]
>> that allows the OS to set fan speed trip points. The ACPI firmware
>> will notify the ACPI fan device when said trip points are triggered.
>>
>> Unfortunately some device manufacturers (like HP) blindly assume that
>> the OS will use this _DSM interface and thus only update the fan speed
>> value returned by the _FST control method when sending a notification
>> to the ACPI fan device. This results in stale fan speed values being
>> reported by the ACPI fan driver [2].
>>
>> The first two patches add support for the ACPI fan notifications as
>> specified in ACPI 11.2.3. The last patch finally adds support for the
>> Microsoft _DSM interface.
>>
>> All patches where tested with a custom SSDT [3] and the acpi_call [4]
>> kernel module and appear to work just fine.
>>
>> [1] https://learn.microsoft.com/en-us/windows-hardware/design/device-ex=
periences/design-guide
>> [2] https://github.com/lm-sensors/lm-sensors/issues/506
>> [3] https://github.com/Wer-Wolf/acpi-fan-ssdt/blob/master/ssdt-dsm.asl
>> [4] https://github.com/nix-community/acpi_call
>>
>> Changes since v2:
>> - drop already merged patches
>> - add links to the MSFT documentation in patch 3
>>
>> Changes since v1:
>> - use acpi_evaluate_dsm_typed() during _DSM initialization
>> - send ACPI netlink event when after handling a ACPI notification
>>
>> Armin Wolf (3):
>>    ACPI: fan: Add basic notification support
>>    ACPI: fan: Add hwmon notification support
>>    ACPI: fan: Add support for Microsoft fan extensions
> All applied as 6.19 material, thanks!

Thank you :)


