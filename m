Return-Path: <linux-acpi+bounces-9839-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 269249DF698
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Dec 2024 18:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6902162D5B
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Dec 2024 17:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCB41D61AC;
	Sun,  1 Dec 2024 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="u53eJX/8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20B62B9BC;
	Sun,  1 Dec 2024 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733073632; cv=none; b=bnx9lr+JE9kSlTFUUaq6+sz+77yLB7qOJHf+GuR7aidhDeUKVCXZ2IK2ExVd0bQxJUnqIbiO7G2x8kuwEcufBwlXcY3GHQGIxzoXyncv5fC1cZKbuW8kdyB3fyD4VCubxyelWhVi3YuDrjQDhVTzW/qrkXF1N7lKhTU9j6PQsGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733073632; c=relaxed/simple;
	bh=u2bFIncavrS0FHGyxnB7nb0RZFC5xFTFQchJkao5KaQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=rzSWNmjMYzQ8YfhxvBwZG1lIIGCoJCMxqbhPAqRofLEzpjkLwqtqsNMkqQCMlGN/HzLCIN/CvLbCA1Pq5gKgdnYPsxM57uCl9nAuN1ZewLrs3nK3Z5QVzkKuIYxT8LWyzoWn52QZlX6W7yqyQJPyElFHV2lzhn+Mn2xaGuiT0Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=u53eJX/8; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1733073550; x=1733678350; i=markus.elfring@web.de;
	bh=ipjQxmbFd+FSH7bHAZVB34gk1qD/mqa8FRKclwAOfz0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=u53eJX/84EfsVLGAXuqux36CWYm8uoiYaP8vZLAYJAsA885lJrKJB/9CyOsqvB8T
	 XrbBIdLTkT/J1SHDUu5fbv48UBMX02BadbZwyLEoCW9YikgXhpy+XMTl6Age8cErx
	 wK3ra8nzCTAjAmnmaVc1F1FrK73ii0b4Q0eVLY9yzaYZf63OjkAvAach+QeTUPntQ
	 /NaUWJqQxGJ6LYj7Da7X2HNPpUoxc3LJBpIIk/YC+ocAnabIO/tCzz38YuQOoWQb3
	 vQTf1vYbHVjdXChAtp1qsKCEZyyoYPxUB11UUsmSrPJXyfQEp/dgCB+IwgPAgMGP3
	 CBnyxyP0Rs2vbemluA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mw9xG-1tYEWH3dPo-00sBNw; Sun, 01
 Dec 2024 18:19:09 +0100
Message-ID: <7947c901-30a3-4e78-8877-08c8696bc84c@web.de>
Date: Sun, 1 Dec 2024 18:18:52 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Mario Limonciello <mario.limonciello@amd.com>,
 linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 ibm-acpi-devel@lists.sourceforge.net, Ai Chao <aichao@kylinos.cn>,
 Alexis Belmonte <alexbelm48@gmail.com>, Armin Wolf <W_Armin@gmx.de>,
 Chun-Yi Lee <jlee@suse.com>, Corentin Chary <corentin.chary@gmail.com>,
 Gergo Koteles <soyer@irl.hu>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Ike Panhc <ike.pan@canonical.com>, Len Brown <lenb@kernel.org>,
 "Luke D. Jones" <luke@ljones.dev>, Maximilian Luz <luzmaximilian@gmail.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
References: <20241130140454.455-10-mario.limonciello@amd.com>
Subject: Re: [PATCH v8 09/22] ACPI: platform_profile: Use `scoped_cond_guard`
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241130140454.455-10-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zk4BcCEFNeo7A7oMOewn2hhWkVgalz0F4D6UGrTClZa54R6XPTi
 G3oR9JsEr43NJIl5pKtzktmMTtu+Zp9FQHqmoFlEsnUXvt0G9Paqg72/e+FcLCCGeDUYXRO
 40ouaus0nUQp4DiJsCf2Hz3MK6VF1WvgEPhZAYyLt1rgI+/RxaT9tPMSd+hf1zzt8xZ/7iN
 G4HHbVvuGgK0OmCIGGGCQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dj4HGFO7zbU=;nrm2+y7HTmb+Ga0jDqC9d4vM63c
 i5RHADWcuYcJUFBu1FH8XMXT1XBZ2ayTKAfYdq1XHqcme3sJ51IkLoVohl3MlxN9RGY5UPEhV
 PHR2J2oWk+vyXX4rLrKIPoknoXV+jlarWeIBkPUFPhRCZJCRHWOOC1W/cDvAUIJKklAXPQXy+
 2MiZnCDaBdIqeWzQR3q+twyKwAPgHkg5jMsYMYvSCcHyvyMvWcFYV81NbEO03xSDV8ZiKe2FF
 5j+ztdgzSlI1MtIazrAuE7A7ZoSCPG38J9kbiTA8OtSjpChmknSOcTyURyEzFvn0n+gSPkbGv
 85T7L/q/h6JpFsA0+5eI6Rk0jDspt+1U6lr47If9FYXz1/78cPECqQPwRHYCnws6i+dlHWf1I
 EYBqgwwqSNGpNk9AmSsO05xOYlAmJkY80CDQ0jSp5WDOPzM5+l8TWegagrV7w/ywWnTPZHFIy
 D4IclEFBXucwSGZ329Q1n0Zm2idsprgkm9vEd2BcLdiDf9GMizdxD6aYzjG6SP21G+UoG5P56
 5q+lNLx15lzTllHuE8c/pA5Kx4kMwP69MTHs1rt5jYCFryB5gcLsg05Mo0HY3q03c5zQBf6A7
 JHHs7l+G1dlbIHRe+YTReY2rnCpKQy/47FZTaS7doQGmgaZVevNU0xfwjID0FjDEUlbUdrT74
 +QCr2W4OE7eJYyKqFxJbpTkSCuwv+3cI0rZdAFTjN8Zlduy0vj0qe4YMsT9OIDwc/wg7+hloz
 jqdtwhhKKHz9L2KisJc9UQNDPegq75gW3BXWHylVJhfx/EEa3DqylCbE7SSOAmsbfamxvZQhG
 /h/+1McJCyboKBC+qFHCbnbGZzYzdKvqPhZd9xsO116JcXZCleVUww+rx324z1hDDOFm35mR4
 mYOeLbiy9AqP3Mrpi6uuWpMGO0SuMPjJzFylWG/aZXgiyBRt2fprL10VnSTNt4WAx8HTbzDBL
 /ReqjFvevTFhc5xf9z4aTRVPyK2SNV9QqGjE8i9hulcnbKTcGszdL2tUCe2OtoKa6LO6JNZKy
 zEANlnfM/XAcnuK5vLeBgWAbn4Yl3GChazoK3YR0DUv7nUqmUN2sacMaKv9RimzS8aXslyzbl
 AJIPbRDgw=

=E2=80=A6
> +++ b/drivers/acpi/platform_profile.c
> @@ -27,25 +27,20 @@ static ssize_t platform_profile_choices_show(struct =
device *dev,
>  					char *buf)
>  {
=E2=80=A6
+		for_each_set_bit(i, cur_profile->choices, PLATFORM_PROFILE_LAST) {
+			if (len =3D=3D 0)
+				len +=3D sysfs_emit_at(buf, len, "%s", profile_names[i]);
+			else
+				len +=3D sysfs_emit_at(buf, len, " %s", profile_names[i]);
+		}
=E2=80=A6

How do you think about to integrate the following source code variant?

		for_each_set_bit(i, cur_profile->choices, PLATFORM_PROFILE_LAST)
			len +=3D sysfs_emit_at(buf, len, (len ? " %s" : "%s"), profile_names[i]=
);


Regards,
Markus

