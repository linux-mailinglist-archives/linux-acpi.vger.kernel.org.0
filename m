Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB7E2FE71D
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Jan 2021 11:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbhAUKHt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Jan 2021 05:07:49 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11942 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728760AbhAUKH2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Jan 2021 05:07:28 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6009521b0000>; Thu, 21 Jan 2021 02:06:19 -0800
Received: from [10.26.72.207] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 21 Jan
 2021 10:06:14 +0000
Subject: Re: [PATCH] ACPICA: fix -Wfallthrough
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
CC:     <clang-built-linux@googlegroups.com>, Len Brown <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>, <devel@acpica.org>,
        <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
References: <20201111021131.822867-1-ndesaulniers@google.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <031790d7-ee26-f919-9338-b135e9b94635@nvidia.com>
Date:   Thu, 21 Jan 2021 10:06:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201111021131.822867-1-ndesaulniers@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611223579; bh=ecknqWhuJL3W8p6oQ0zL/CmHsHXhDRwgK1lykE3RJyQ=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=hQ9ZqKLYBvSdVpq/QxZyE+ROLV9WzIzI1NNn1H29M+eRY+CERXSsX24rDtifxNsGx
         gJ2UWTvPfHxQPkxRszZlLARzfL9qwIiYhq5F+2t79hEujT/T5wE8Yp1RaXH2zb0fr6
         KHps9XcTapcsTT97zKDniQRCU4yvcwZ70NNbSARxqEtCZ24LK8kFgvHFFYcec4iQiu
         K6lnTBYBrtu4Nzw/d/leu7Jb6yGNZVVUz/AaQE498WuZTFrBTbJAIJhmhvshqTfCI4
         C39BAL/NroKKXoA1IGLpxQLmfT0xYmlLYnLvjg2yPkM/dWCj7zdbg5clw5OrAMpJ7S
         lM34IV6mGryeA==
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 11/11/2020 02:11, Nick Desaulniers wrote:
> The "fallthrough" pseudo-keyword was added as a portable way to denote
> intentional fallthrough. This code seemed to be using a mix of
> fallthrough comments that GCC recognizes, and some kind of lint marker.
> I'm guessing that linter hasn't been run in a while from the mixed use
> of the marker vs comments.
>=20
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>


I know this is not the exact version that was merged, I can't find it on
the list, but looks like the version that was merged [0], is causing
build errors with older toolchains (GCC v6) ...

/dvs/git/dirty/git-master_l4t-upstream/kernel/drivers/acpi/acpica/dscontrol=
.c: In function =E2=80=98acpi_ds_exec_begin_control_op=E2=80=99:
/dvs/git/dirty/git-master_l4t-upstream/kernel/drivers/acpi/acpica/dscontrol=
.c:65:3: error: =E2=80=98ACPI_FALLTHROUGH=E2=80=99 undeclared (first use in=
 this function)
   ACPI_FALLTHROUGH;
   ^~~~~~~~~~~~~~~~
/dvs/git/dirty/git-master_l4t-upstream/kernel/drivers/acpi/acpica/dscontrol=
.c:65:3: note: each undeclared identifier is reported only once for each fu=
nction it appears in
/dvs/git/dirty/git-master_l4t-upstream/kernel/scripts/Makefile.build:287: r=
ecipe for target 'drivers/acpi/acpica/dscontrol.o' failed

Cheers
Jon

[0] https://github.com/acpica/acpica/commit/4b9135f5
	=20
--=20
nvpublic
