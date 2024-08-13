Return-Path: <linux-acpi+bounces-7546-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A15D79502A0
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Aug 2024 12:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58D881F21CA5
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Aug 2024 10:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3901194A5B;
	Tue, 13 Aug 2024 10:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJR+6hSf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F07E19412F
	for <linux-acpi@vger.kernel.org>; Tue, 13 Aug 2024 10:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723545660; cv=none; b=WY0gp0SjedRWA32ewyE6QznjVfu9Dtvf31qxrPL5FG5bIkVFp1GNVgq6pYcfm8uewMPuGdKq/ms4ZMbvf+mx/HgHBzYDJO/XeYgtHfPZZ9dzJO5dCdG9fkY1RskBMXKgCFAq9oUJgct6/pA7KHuPJmM9Qt1FZ0Q4jf0kixzuKBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723545660; c=relaxed/simple;
	bh=TH278hex3/VoRFNgyoYTCSneOWwBUJNDMRuRqYYyHoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iQvf6x7ek1zOU9m0SeJeGoMf7mNA4wrLEtev65y8j8N2fQcEhjLkWsPXSGXxxrjqt7J8DaIUNWu9TOKtryeCOsNDsh9iUEP0luVo2uaBeLCqefwJT5uel4ApN3KSRSmKTFTUVV8AB7TZoJs+u7Pzi5TmuzMxQh1PDUXqDMlZYPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJR+6hSf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C24C4AF13
	for <linux-acpi@vger.kernel.org>; Tue, 13 Aug 2024 10:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723545660;
	bh=TH278hex3/VoRFNgyoYTCSneOWwBUJNDMRuRqYYyHoo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gJR+6hSfnk+QvVOfeIWp3rEomvDjmwMFFpQ1uf/Zq/5sfBk0VIzOsuAzWap1J5aqg
	 Bt70+o9zq4Ik0mMhBNz4uZY0NLl/jVBYGzF5SzbFBv6UP+SM8llTyLVrRr6UqAcNjV
	 xwabwzU2HZp0VDkPijRTbTE8C7gF9FEe/lc6+ezwcpz9zF4O4GMcA77ANa2Lk5O6W0
	 zK8arTHfWvIRjW4aKlcUmRB7tJSARG8r+/Z2TUulxQ4nh7VcEwLNPqpnDW5Uqt4UF3
	 /bDY6PoTlso+Clu2zSRJt7pQjBx+XbhIKYForYdUsWNGtqRK2YP+PI/XeLQBqvfy+S
	 /RA5ISsA9BrDg==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-268d0979e90so599387fac.3
        for <linux-acpi@vger.kernel.org>; Tue, 13 Aug 2024 03:41:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW16ME+bdMcKe410CexkaLpHjJb8qBa+MqhlHV202vx+qKxa1WDxVhaJGY0GwZknc8JTIaraLWVf0mH@vger.kernel.org
X-Gm-Message-State: AOJu0YxF95m4iIhQWTObtg4sBPGl2UqioWRUfr9EP4/RKwzoN4MbMdwQ
	HQb23OlVGUD1LUCOPKlTU24C5fTCNpCg7H4cJStvBLK7OSeqJNYQwzmp4sKpJVI+Mha4nmfZ1YY
	SKZL+POPgU9+yiD1zhXUMBaHEd0I=
X-Google-Smtp-Source: AGHT+IFPwJ7/Dun+U+Z0MvUzoORMR5XDSwK4N8B2sheMDbN+xYKBRgDT7kCpY2V83vf8yw0Jd+SbEUDuwe2hTgZHF7Y=
X-Received: by 2002:a05:6871:592:b0:25e:b7e1:d20d with SMTP id
 586e51a60fabf-26fd16418d2mr1080237fac.0.1723545659463; Tue, 13 Aug 2024
 03:40:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1f76b7e2-1928-4598-8037-28a1785c2d13@redhat.com>
 <c0e5414a-ec7b-44e3-980c-e71889150767@redhat.com> <0abc1a17-e155-4587-ada9-13f9ce5f358b@redhat.com>
 <1a426f61-1454-4a77-8262-612ab1d0d265@redhat.com> <CAJZ5v0iWy6oXRJ2mxhOLyWsmgp1akVjoo0i2pqDDMOg-TvWLPA@mail.gmail.com>
 <a0f54ea3-5830-4420-b4e7-73ea8c146bcd@redhat.com> <d7ea226a-24b1-42e9-80d7-039729d93d34@redhat.com>
In-Reply-To: <d7ea226a-24b1-42e9-80d7-039729d93d34@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 13 Aug 2024 12:40:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ivbV0h+gmpL+LCUfdDmExjJ1G60jQTzf76iWy6aT0e-Q@mail.gmail.com>
Message-ID: <CAJZ5v0ivbV0h+gmpL+LCUfdDmExjJ1G60jQTzf76iWy6aT0e-Q@mail.gmail.com>
Subject: Re: "EC: Install address space handler at the namespace root" causing
 issues for some users
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 13, 2024 at 10:46=E2=80=AFAM Hans de Goede <hdegoede@redhat.com=
> wrote:
>
> Hi,
>

[cut]

>
> The reporter of 2302253 has reported that the patches from:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?=
h=3Dacpi-ec-fixes
>
> resolve the issue; and as mentioned before the reporter of 2298938
> is not responsive atm. So I believe that with it confirmed that this
> at least fixes the issues on the LG Gram laptops (1) these patches are
> ready to be merged now.

Thanks for the information!

I'll go ahead and put them into linux-next.

> 1) And based on dmesg with a regressed kernel likely / hopefully also
> the issue from RH bugzilla 2298938.
>

