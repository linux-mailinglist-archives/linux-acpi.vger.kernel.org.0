Return-Path: <linux-acpi+bounces-18920-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4657AC61833
	for <lists+linux-acpi@lfdr.de>; Sun, 16 Nov 2025 17:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA3544E2CA9
	for <lists+linux-acpi@lfdr.de>; Sun, 16 Nov 2025 16:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1892D8DB0;
	Sun, 16 Nov 2025 16:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="gN7li3/E"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A5F1B87EB;
	Sun, 16 Nov 2025 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763309608; cv=none; b=dQkTOh/PVOf8lzkR83kVW3XSqLUwHcvMhUQ+SuHo+MOKa/FktNKC11ZT6GjWdb7I5XHQRNpXbtDhYLCYyM5j5t5dQ7kXSeqF02bHvc4gqr+Y3cAzOp7LlR+alUebsrWx0EOgXQoVJURtYp4TYMuUlH0JFwMvIeBmfhd6eU8X3lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763309608; c=relaxed/simple;
	bh=Zy+NvpVfCtMNygayaF4doQ3/9KnkYncazVL8q77+v3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pfmsu/zUv6caP/oe4CuNqatoxiikPjbuVboP4U4hvRLkeGSU5t0d7kUmWKreiOC9XgTvX+lkU46G263A+nW28Wxmy6/9INvOc7QGW18a1PZszNqFeMOp4ctO81GkuA+v5Wvy80ZZ2Us0V/OOdpJHHZPpTv1Sy3sumO1fR/S79o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=gN7li3/E; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1763309600; x=1763914400; i=w_armin@gmx.de;
	bh=9cKNp6qlTLgM85Jqn0pIIWI8mNUTORXnUzHevT3dbrA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gN7li3/EkwXR6RKnsU6x3SzILUxBmtKfSePKeHLld7woKbWkKxP4hWrYRwpU7zTS
	 nu/tZdg0kzyFgLTF+5No7wRA3iGH8vmiEYNoOPwcaO7Qx55vCNiOo+2yQ/Gy84p2i
	 RhorHpNfzmL76r76EMtwgXXyGbCILr/g1qFFzH2doGTsfCOH89i3EyYYNp8azD3IH
	 Scb52TC75/se6YesUOKV6jG85hNRujUmp1Epcsb37MH9qCFSl5zVwB6S4KxrWkGM7
	 SDN0bcx9X+hzdSDwkHQ8WFyxm3LzOQfBCVBcYRzBH2QSMDMZ0iN7g/XHsImCQflzY
	 d/XhULxijfsjRAikUQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDQeK-1vV5Us1hIc-002D4G; Sun, 16
 Nov 2025 17:13:20 +0100
Message-ID: <7050cadc-9cb7-4f9b-8393-247bddb56965@gmx.de>
Date: Sun, 16 Nov 2025 17:13:17 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] acpi: platform_profile - Add max-power profile
 option
To: "Derek J. Clark" <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Len Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Mario Limonciello <superm1@kernel.org>,
 Zhixin Zhang <zhangzx36@lenovo.com>, Mia Shao <shaohz1@lenovo.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
 Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20251113212639.459896-1-derekjohn.clark@gmail.com>
 <20251113212639.459896-2-derekjohn.clark@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20251113212639.459896-2-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:b2qAivA0sY8B/FqpX8lhQ77Ev66LWVOHdH7OXRgMcKIfIwexBUu
 rV+otpmHUeq5yMoDGhmD6/QTzKnB2YAX+PgcULvJOJtNJrI/in92HsZUa2vQm/8arI6n+q4
 rSTTwVUAk8/wS4sA9c6KqWwOgdSWyr+XLasBtSv54T87jOhnShZ2KUmQCvOkESmqJE/Of4f
 Mb9DFTBf0lVg79lOd0VzQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VGvFkbf6P7o=;V1bO+xjPu3JhroU0j4IwQETQC32
 JY6IZoxgGzFdUfwUCnb/pWjcryjgnhzP4o5vB1vu6Gbud+9r5XSvG9OeKiohWl0ZTvtMu8HyA
 pBtZ2ponaM0cHAZXvSVu5Szo+fbShMUIHeypvfGcegn7WRluPp79jUrRY75UZFm/aaUX7N/rZ
 YmxQzf9/Qn2Nx8qxGF8L59ngUajsOu2SrgjR/wvuy37e+tY+B2iO5hQVYFpSMDxuTYC++ae/W
 WOcvnOMLeZlzC7tfDS1zZeR8QDAEjJS+iWIxqoaUVoqF/vKX5KKi2mIDeGPqARnx7ANg50MpV
 YA/ew0qVwaJY3IUL9vvXcY9D5+DuRbpkxhy6BWAB+TmzpfK/Q+Sx+EQiR06Dxe/i8IbEX528T
 pEWwNKzRMVKJPfMApSh5Dt3g4iNO+WNpFFcN/Ma0Tkw4b8Szv1ilVnwttuTIvbtb0sFIITq92
 tfs3kAdW/qATYAOTQNVC9fKKypR84M3EdWH/aDyuBHdOJV9SiX3Js5xjX4PDts1nQdkgmkdgR
 k3PTeDvwO9ERx1XZiLA/SvFbWkJwYLT2deOpLtwgLxThcEusrsY291kqHuToNcgYzlqnjT3yN
 9YQnhYCYxfBDEc7e8JtZXIne34+bAWrUF14UXkAvqatLjr7Ehl4zvhJ/1eq2FBE3MJL/7pCro
 Qvj+Gw+86iwNg0umzhmTqEFzZTYwOsqJ3syNp+ymlV2vYvHb8EL4vm8OxGqBzebc01F9IgQ9i
 EXMqLuu3ht0apOWKoM6shwTd4nxgSNdb1nLIU0vOgzAzSa+nSftXZdfTMbdGTkXCLkerdsSyz
 lAvmNJ+IED3FM5Hjip8lTJMwOP13QWOhoaNyQ3i0A9thSewILCDDgjv8ZJs/5UQHG1rEGdvTD
 KzE2ORvTjKmto0dBMjJWCCwhdJ7sYfORjkJIfd904MfPG3UmxVE+SD6mUENWHYO5uY35wzuwS
 Ucwfutbw/F7HgENRnwLrokviES+ShMILEFzGEQpGfmDBEDTJAHP9+KombDVBrCLVZEgXhUBpJ
 2vyR/yBkn3rzcZF6gi0froGxocJOxl8VgDGi/Yw2csVwlkHHJbo3Gb0hxSGBcTcwtIfWl68I6
 7unP7peiuW28RejxgPfSo2wPqLrQDkGVWBT/LVZgkjJ9jT+JJcA91JpwSt12xOhDIO6QV/uqt
 mohDfOjSLWxWUqy8/XqP8wNsGI/wiJMUu769edjpDkGA7ljP0gnuEaiB7kBnnsCkzMwN5mc21
 JQIE6vzKyyHTUHqtP7+Qulcq7FrHHGXijXs2HZW19qYRtCQuQDowzUiOyWN2VBFr+BEfq/M1w
 J8MJ4JXAsUyScBnmQFDrE+Cm8FAR1MH9lsSpfWEDUatTONudIwgtB7OKUewjR2y2Nnx9+5Roj
 txnAz0XNBiJ94krppzpw5u+1hdzf1Y3nHmXjbRSkDXU8bO4FCo3qk1NLyuhtHk3vFP3crjDyL
 MqqWt52j+QuMikKqMDrCv81U73TxAdKzRrCYIm7W/Tx+4WKKbuDiJnYqPaBIGomNvelWOkI1E
 d9vS3+Uakg87FHzlGtfl9GnZkHj6ywdHH4vnYUD40E8KsI2q++Ym/Wcx58gvKncfkcm8nt5Xb
 0Z4lUQiljFqg1oyrNFvZmtbB+Ot9uaI885M+T85nafpeo4z9v7CfbjC30KQmMl4z7p6FZoQY4
 mycIT8nkn/bLzstoitVkTnqWPQFbvOmG/+08mHjLG/bjVbjS18mfOkF6khpnNi+EkegYvZHPL
 T14c5JUsbQ27dbqg/RrO47BEB5OgGHuRurRzPZD6Rl4djU6kgrJwfXPnUDx1ulfmtGvwseUFl
 gqeAusxFlipESjlR5F9qPHIwmyTkwbfpSYC+t31nO4wzoROz0PdBYvmFwSqK7cbOUMyqqmSkQ
 LWotwiRZlo4ace4jvam/k6ZIVxuZXGcHj/F7gR2fKD9m+jKwHbQRjJiLJbxoCwHxi1IdxHxZI
 dzpNUyiXIEq8P9erT2/MGx2m5WoiaN+Y+KeRRrGWItGo+gTsg04jbz2EIYFCQyDpF8MpPWmkb
 fy6QMo/2Zdsz821BKRv4kji2NHJEUCC99O54nwfKO3AYS2ZaiU/nU6vg6I4+k1bxmayzU6ytx
 0Mq/C+KBJ2iXvJqdBWnRb3DzkzTGi199x7dzku6yReqsUgIwb/q1P2GIJ8bq/qvEdlQXPSieQ
 aS18hfpgRM/CqohxkMosc6M7bBTpEp954lIGsqnmzkad8BCqO77HnTztWAFeVu9ZqWKVXjhzf
 QuC71bB4AvLwThicOrEFkS3vfzZC8q8kgfl37weSQWiqSKugjCS/Xmu7lfPyeAd185k8GtGQK
 sp3gxQ1ce7Xna1fxTOGcupZIJIxP+r5KGZEjc5+uMwDRs/+9lHr1sjeWuXWbgGahQUdNhx8sk
 zLpQp9Ci8OwWzJmQXECMX9/GWwe3jH3A1kC/HdQr5b+1s2PoVRlnHhb0NCh5pQ5ujAfYoATUe
 nVukwp2uroF1UVCJi2rIhsoANNrJMYHT/AGpqps4UEOrM+kPYX2emO0c71oXIOF8Jir2js08e
 pE4z4SK5/N25RttfHxcGOiq8pjHT9LZO98vlR3n+pZvpvLX6bDVitD2hN0+bGjTPnW9G6IAR2
 iO5fWWAGl3wXlZSp3TLZNph+yq5PGWkNVScOkzfZ7EktG2m5MvY0JolD0hWFG44ZPUCvLvZDb
 rOnLPdnAGmxfMcSUsD0M+hklu3jeR5OYZD8UO1NcaznH4hiGYlfTBt6fuTQep1Lkiv37GpZSx
 qtIQJcDEKXUs8sbhDczFuBdMTyhW2g4N5WJOcFeI5m82flQ8ufmFULH66gvRsbILdEQbb+zWj
 WTNMpBOgY7bPRm0SVgvYkHHgHApQiNtU9vhBUGmq07kB7Y3HUQh3w0BiXu5IACClH2sAweoHy
 h3ZNWhK9zed7E0kdFlveMdYO0wtZo6ImzwiU3XwFyXMY483xzqGGobJyx66TZF58rSFs1Ga8u
 sVdANir4/aSO15rjCqVeipxucAte44UpJMbmt3TdQ53ZE4roFLggO131NUhHX3V9CQCXv0pW7
 E0e5PzL6nqqvtOuQRIG6M30bukUg+qfJSIyJmAcUxffYMjUk9fhZLiSBLRwf2zao+cnCUodvI
 AIy4rsYWTomBYsYBCKLFvm0lmqwxZENrJZPoBRHqw6gkcXIQjFFQ5w1PlIoK70GZHpWiBT5X6
 apH210iZwwA3cLc+f/jNfOuBdr15AXj15QSq1M/hO2BtDHBLxfF06ih4O38jMxb7mwa/hEfjM
 DeVraajMZbIb7LroGbnG82+ezeiJ/mBMQNrlsKshk2y+L65bz9W1sLcDLHUQ/09J/nORE20DY
 F1/HRyH6yoEndpp/MMb66xKbZA+OF8qveyDZ+EHXvn+PLYPBqmg2hx55Vl18vLcj3bxUoHREV
 owUG+0tuof7grLp/yBxlMxNo5Dm1VCpO6SCPYk2ErzvL5ei+vtao9ahf74ee2gNF3LKHRclK8
 9HgDkPL1UQ14KzG2JyfxPYGUrBvg2OkBECMC5O7neOu0xfzZx1PQf4dsPXSHR6754H6Wk7YUF
 pOHKErQxhHs44K0VluOUry3WWtdSK/UN4wI+iChxgBxhDuOCx+tEPOVppKUQVLIKtmNvczYs7
 OGy0R93S8GP4BEdrUxrtk02oo8pO1pysq7sJaS2g4wGQT2xAvdecBy+CDT/i57/Jyg/djkrHJ
 97N5qwjgklFzyJOwGF9LsmMyzgbnJlXUFUDwj3UYkcdDIWaIs8MaeI7VSot85sTW0xpmnukty
 riNRiyGrn6YFj5TYHmTQyqd9u901HBvtVyIn5Jusg3xZ+WWttz/uUIP9CeGhYWxYGzLNfwjhz
 U+vYWwAiv/mxlt2jmczXU8mkmOEc57ux/PBI5kRBcp8O3puDJBxKnblA049HpjRFfLrKK7F7b
 PoGgm6wJQGydIQnhgixd8ddef1J0JXMvqHfHtbYVjOSH/xMcnDdnjiHTLiWxRPpBTt4Gtx7tD
 OtZ1l4RkDI6P4NLl+ApcWc4GUtOQHK7xfVZsWdeV8hEfYJX4+DQ3XPJ+FgHYwA7BXykOfPzp6
 MQIhufSyfnvYl6kaWriBNyTsVgoyjP7CRJOO4a4+07hC2/8AuEVhhQIzr3aHi6W/fds8rkj3R
 E9ElY1BWoWV+fRS7MVcVJhjcUkCOEkqWpmMoi6wSltxHKyJZUvJyzU1dJYEjhOgRmdf83QaCt
 8Jzaq0WYT70x5cFNRoAbw6m30F3+snX0AQ5qHak3xTC7YXA2YL4BYLBrBxLMiR4BiQj/lR42P
 bkgcSwLlh1mLsfbEcUX/wvL6hs7FY0ABfRSCIo6t6rPV9YwKX9D5JmASCaqC5Nhh45LttvIGw
 4Qk5AyfKXqMa29Ir0KEe48Tl3VwpcLrB7wazP7P5VRGEYxtxroEwuVMNPOknsaH5p4XunvmQF
 TxDldfD8oweIhILLpFpg1R8q9QoU+dz6bJJ2RkpQ4Dei5VLY6MbbYwXYcnyqRab9MeemFh86n
 s9ocqHvH5O3o16Yvxm+xfLfA6v3R2tjeu1fLDiFmFYN8tyIYLXkQjOL5PCA445hB1RGvZdedG
 D3YsxlBHZWrCcebrs2j1AwNY1S095tYRlYx+or6uitDY4+QVrm7RRMgbadlaF9I6vDfO4Qo2X
 KHdvRHij+pAHHs/MuvgQ7gf4+fVw7Gb4G39qcPOHd64rVDa3gAmVoqVH8fk0biWIjMob6iNP4
 oW7qQ2rx2XApMe6ZTH+WvasfrMkk1IWtG4S6z2dLdJTjR8Upo734CvslDQ0R7lWoNvy5Shd2d
 7ZrB2wsgb4iDHRlU/ehXUEvdaTm47/+8Ki8GNa2SuYQTh5pNQ8X2j3ZpI337i+e3jyK7l64KG
 T41K510i5IFuDKoolPXXZ91WwrqzpNqMDUWm1xeBDfasLV+7Qe+S8AaO/nRaL8Rol4CNpCEEb
 8coRsPWhOcTHTU7102jfkpUjufSK3Uvwuj4IjUQuJ80qYZVKVqwNmZ4bABxXrXakY0qgJLk0r
 RYlp3ydoOoAponwCGTiSuImDBUN/QUupwKZmAtoPAyj39+gn2ZCFUkaZ4yvtrbxSUQEY6wTHx
 ITBeW0jXoQ4w22rrVFRfOBQ1qFTR+i4Kj4Xi701ffzAEqdRxoMhZau4Jw+X7Ofcauu7gZ2nV4
 V/LZNDTzyOR7F19zw3mL4fbfo+NOKvUsUqmLB6NUjEgoLuZ4OoD4SvuHXQ8Q==

Am 13.11.25 um 22:26 schrieb Derek J. Clark:

> Some devices, namely Lenovo Legion devices, have an "extreme" mode where
> power draw is at the maximum limit of the cooling hardware. Add a new
> "max-power" platform profile to properly reflect this operating mode.
>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> ---
>   Documentation/ABI/testing/sysfs-class-platform-profile | 2 ++
>   drivers/acpi/platform_profile.c                        | 1 +
>   include/linux/platform_profile.h                       | 1 +
>   3 files changed, 4 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-class-platform-profile b/Do=
cumentation/ABI/testing/sysfs-class-platform-profile
> index dc72adfb830a..fcab26894ec3 100644
> --- a/Documentation/ABI/testing/sysfs-class-platform-profile
> +++ b/Documentation/ABI/testing/sysfs-class-platform-profile
> @@ -23,6 +23,8 @@ Description:	This file contains a space-separated list=
 of profiles supported
>   					power consumption with a slight bias
>   					towards performance
>   		performance		High performance operation
> +		max-power		Higher performance operation that may exceed
> +					internal battery draw limits when on AC power

I am not sure if it is a good idea to allow platform_profile_cycle() to cy=
cle into this
new max-power profile. The system could encounter a brownout if it is curr=
ently operating
on battery power when selecting max-power.

Maybe we should prevent platform_profile_cylce() from selecting max-power?

Other than that:
Reviewed-by: Armin Wolf <W_Armin@gmx.de>

>   		custom			Driver defined custom profile
>   		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  =20
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pro=
file.c
> index b43f4459a4f6..aa1dce05121b 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -37,6 +37,7 @@ static const char * const profile_names[] =3D {
>   	[PLATFORM_PROFILE_BALANCED] =3D "balanced",
>   	[PLATFORM_PROFILE_BALANCED_PERFORMANCE] =3D "balanced-performance",
>   	[PLATFORM_PROFILE_PERFORMANCE] =3D "performance",
> +	[PLATFORM_PROFILE_MAX_POWER] =3D "max-power",
>   	[PLATFORM_PROFILE_CUSTOM] =3D "custom",
>   };
>   static_assert(ARRAY_SIZE(profile_names) =3D=3D PLATFORM_PROFILE_LAST);
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_p=
rofile.h
> index a299225ab92e..855b28340e95 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -24,6 +24,7 @@ enum platform_profile_option {
>   	PLATFORM_PROFILE_BALANCED,
>   	PLATFORM_PROFILE_BALANCED_PERFORMANCE,
>   	PLATFORM_PROFILE_PERFORMANCE,
> +	PLATFORM_PROFILE_MAX_POWER,
>   	PLATFORM_PROFILE_CUSTOM,
>   	PLATFORM_PROFILE_LAST, /*must always be last */
>   };

