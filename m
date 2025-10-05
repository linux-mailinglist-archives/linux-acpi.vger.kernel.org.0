Return-Path: <linux-acpi+bounces-17596-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 524A6BBCD75
	for <lists+linux-acpi@lfdr.de>; Mon, 06 Oct 2025 00:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A60C3B14D3
	for <lists+linux-acpi@lfdr.de>; Sun,  5 Oct 2025 22:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCDC2566D3;
	Sun,  5 Oct 2025 22:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="hGhb3JZ7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B9023F421;
	Sun,  5 Oct 2025 22:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759703138; cv=none; b=Zt1Pf5lvLOMtBiyn1l2dXmZD/2+WSkhmwtCUijmsUKxWMQ7KzNJVqGOCiRPUVtH1i/P2DhW7YNBSeqIfkxqgWmqBUqA/p9Yxg/Toeh2h9vVLJHHlJtQshcwMCyhEV1tx5+wkepwgSHrrnoY0dXGUJSe2raHmsix6HtSY00++E7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759703138; c=relaxed/simple;
	bh=GsodGw3Pa5I05maEkD4DvlWS12xOGCtbRrcjv+ZL8Ao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UEFrO9k1HAnSrnzdvB3NGQHuohXPS58tcF4/3IMj1GCyJVqNFPD7j3anpVLUXB7qRuOXd1nPCLaQt+BIAHihqpvRDu0WuWMKuLPqiJYYW/tpnft1QuQkEvspnWZviauQN+IKrPSc8whSuS1IpxzoM0pOHWNIALbb/mA/fPn/hb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=hGhb3JZ7; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1759703130; x=1760307930; i=w_armin@gmx.de;
	bh=N46U7ktiFSoQjTbVJEfPGL3jUZUVQA+SMnH4zeVlSIY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hGhb3JZ7BAocKxTBXAYw9s6pOU3dasCg5ymITgh5yad6epDybwugP/gzmFZUkqPH
	 5NZGB1z4seh8p4K0h2QwvDwm15n77pjqUo0Jk49Q6MQ9xSGRkbroALo2Yt542nneo
	 MOnmUX2wtlArHNW7CMek+U5xTzxfiMQS1rr0qxKHKTTazwGIL46eetwyzeTezyFFG
	 laDMd1yLGTLKRN+nFSTICqczYky9qlhxGBj4GnLvLuMRXLc0Be78EZieTnocj4A8z
	 Dc0bKywxA8Kxeh6XE4ZfnjySgKjxlUCd1fx9YhHHz/jF5OfiBmYLFfwHlyRiFXsrJ
	 Wiebfz0cAnczkJvK1g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M9Fnj-1vAkUn1dxv-00CXUu; Mon, 06 Oct 2025 00:25:30 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] ACPI: fan: Add basic notification support
Date: Mon,  6 Oct 2025 00:25:11 +0200
Message-Id: <20251005222513.7794-5-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251005222513.7794-1-W_Armin@gmx.de>
References: <20251005222513.7794-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:07WqVr1Wn6Lctl38u/+daflgvnwLNDyLPcmnObNBzE62UnLpqlu
 hj27ryVackktFU71lEYxhhkoKWAZ173DXV5nHdLJA/EB/Z0z5DuGEjql1O4SkJ4OACqo89Z
 1lQmnmm1NBev4MOphOCvPZSF0ICSokSq6Z5hLmmt/V/rmYpudm3ABxhnYR7DVW2NSDsqziy
 e0YAUACpQg+SAsuRinE7A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4RGpwiO2FFQ=;EwIEfR+qoA508nWHfaVrwsQN6Kk
 ZDN8L0gXtEvY1aEaF843JWwMgeh5yIwzYWGh/JM2nY47E5SCrZaHXrOnlEQiOETkeA5clK1ZH
 M9jQpOO0uq4NXeVW3wsV/8v9xLEA93H1AAcqKr16jx2SEOu7REi6kbPeH8bi07pWqfg+YR2/3
 f5ftACN00vqDG6tTmW2g0VFlIJkHtuJI//Bhmd3xsJMsCSp6FEAh5p6AHBqd9kr9tiYvJtHpM
 uJTJEcPN7k6kIgcTaS9Tzmj8nUd++I70pssXYbBFXeSM0PjSqDrBmTUXbkBTjs1sRYiV2sNvi
 0npirIMt3Ts8BN8eFHPDWLHEm39OBIr+n0z0AlbSoSj/qf4OLdkHTRa1urni7WPLrA1dwyyfp
 zjm9fZGmo+7lUimwJOgVOXrAovbox4Kcaq0sEY3LbaaJSPv+yRE6M5HhxP/wEW5touEhDpyhj
 pzv+tikul8OqjI7IngaCrm554xBse6HFrfScCaCThf/hAMTX7TrqAO1bDkQqtHhyJRKPSkd4j
 MZmizyjwwFPBagQplNaYnbUCPVuoyikmNFV2B4ZF/BUksMoeb7nGKwsZrAxU7QDjlYFARwmmH
 2ZNGWG9tdfz06j+K1vWVkr3R5G9piTqA2kjpmT8jRav4vlrbEJjIt2v3xyK8ZUCdAy9xRsaxM
 ntygczKHv4XNN6BVo9qLX2vIBp9d/HE72By5HcAlx6oR4YrDv/40wr/bTGfLclPbmjqtcBLaB
 8jKaJRv61boKXPHUSHOaLUaPrcb8/KKPK3PvHR/N7WCz+FKO2IW+ROGHk3yC5DmJsGpM5ACaG
 3tcrEUVYXnVCfD1HZXMEXxUbPZ+70fEUJhIu7rElV4I4H9mWVioZw/jxw+Uq1YWp+SB+8Nl0e
 eoZsXxrDWNQR7dj942ZmSit5Uhm/VugzxEApeEh5WWjROM/mSivwV4I5Jg/IRoht+kXASvK9/
 /Xg2eKxFY5b4BQM6dxuWmfqA1xIbn9ZTnyDJgJWrQre4kHAj4VFJlMY+FSF3XZLWEZseGU2ru
 alPcJXKYwVjMwHANOSz1uAnWsPNPKqeATr7jgiRLTODGTawSFkIc6lT3xMB5ergcOSJ+T0yp/
 XXWWEJuPSgDdrl8wdJ96EJ4OvlcSHza+mmiapdsVN/lyR7InW7tC97NjqQCtiO2O2YPqinoMR
 PAC4xUq/1DYS8qA5CodypF3/HJ7RXb70lMvN2vBDn53KswFnQ+771APe6mHwcIH3RaU/G9L5B
 aeXS/f2eONyglCBTem2YV8JkIwWgLXrV+t9WX1KF9kcSLlLX0ueFUaFur3FMoVjoBX+04FsHZ
 5sEnWfwGE00Jt5C0gnGeU1zF7a9hD2Mzoo+WiXWnUu4U6+4rgsIiuGukFhbKmptOP5ojFsxiB
 t5CIiEeOdqBRKzo9TdeeNctgFmVva+cJyqpxlyr+m7CsGnnqTPl1pzQO1eJ7VoAggvDaunVpD
 RniYRHRMRd5/KSeCCrqrwJpI8hpMbC9J/wMMSnnIdTZ2XQO9/R6lQibO2M4S6CJxTEc/PEzRy
 u4DiVnf5vRS04MmOWVTILYiKvqq7fF8+UO7pbt1n5Q3kWW/QVEPkpQO8pSJTKp0oWxVHFW1Zr
 U14A6+z71crEOclL6mKfHBUkfjoY2fVUORlq+WEEsNtSC4QmxS3dwZz1w+lJXTphp6Cha75bV
 cWB2BOqc+vQtwXmBCJSa0Bq65WvgVJyrH2Q+OAHroyNKG7HRi2UdtqBuIS6d8wkOuSk6peHUY
 QIyrpe1tCacjOPbjMROhTmjoQXpIsrNyluk3xIYvV+Ng4Y0jYfbk6Cn2Atf5qChYaxctz4357
 zhIoe0QpzIEwJcKr0e9bIi19sxbGjQCvlNRqQSD88lXanELdax8cYJVXJkRhN+gl4Yq2OeFlt
 hGQsLp6uqH03WtRLpr313tkSVqLhRNo3+2swfWWV4BHFpiC+PTZE8EvVBwd58B68cOez1OHho
 /lZ7xf+FfkbkexT+wA6E6P6aWtnKeFS63CmH1e7uO23ZhukRBUe9l+TFY3U8vfch8vIi/Weq6
 knTGfppcCRL6WwzaeKGULG4PdLCf4SJGySSV0LAqIm9+ONBY0DX0JMbEdbYGouexie7chgQbE
 hjdh8Y5/NGhl//W7bvCAmADUB5YKzSGMS+zZFY8jnW1HqT0DSbt667IfnOg5rTwli91Fm8imP
 5wcfaHjQM1iF+eVizeXjsbUt7OuQVVVdwEtNEPDyFYaOL/jx+YqZ4YgTCkSaLWLv5kohFvvWB
 +eF0O5LUN7mnqqfU4UtYOdy66IjIPVf1ix2v2ksgO2sd/4dpg4zTqJc/MUUDlSPV0RoeN0KmP
 xDPnNg/JLbEiPz+Rtv7AYsbJQRJwSFdrv2XygunuQgXlCwq4zHhiY/IAnPKtWtqB/vuzv/p+P
 XO1n0mWMtb12JQnytb5a7Jy4oVoFCyxrYK7nF8mYTEkHvqv0dB6XTV7r9R11UreglcG9UOotX
 12Hmjp7wgcoIga0nuWPu0zeFgQVHrdO3xz7ad47iJm7LWZ5dy41Ty713k14umcE82QuD0m5JK
 XymN8wr9NiL13UCs4xUCTiw76ZWjMGjxDV724JN7WtCIaJHZK9fsM/Drn/8SQ6jTQuz18pUk/
 jk95/Nv+3FZ2WMWTqn0WLOg69mcCcBijfNzQt68qWkSp/4E6J6tnAuJufhBr5dWCFzoKwo8xt
 ZNDNsOjLugTrmyqOR+SVwPBD/o+mJ7o/ZSI/t4M/azwzmv9TTPW7FzWbus8yu/gTkk2hNYEQr
 L3jx6z/7NWxQtaw6k2wX0RBxYIUXUCbM97NF8npuZl5zJQITMI5SeGr0/BUDm8Hn34aH+/pN8
 p8w8tpdAfxCcBZn3gW6uCU970NppqBVKRD4OX5dZuJbnr+6GpRzevYVbUVT6mZPyXXqlS1u18
 NeLVIc2qRtVV3dqSR6bbJ0rLThgqVed+SY/PrhAKi/S84oZZ0Y1Y+V83YweMW0ATVTTiEC+DE
 9RZUC+CDaSskGWz/jtXZWLwVQDvsy4UNW7bqwHpTyBB4U6h8FkhLgZZd/9cl5DZbD0GkezWcg
 OnRyRMsvomGtrqgZYvcLgkocNn2lbSw3O7bjCSgFpZj5SwBZzZW4zXLlvSKK/7P5aYbnHAIgn
 iCCLQ4SR6fBiUfnoT70pOfFV5UC1JYMP3VFxfbOOqXjaz6WoJka4RhzxINI07SYJ+MCCs0pvI
 c3ndLHVXV29SnkHB3qBr2dL2aj14g5lxsq8yC0XbB6m+9ml4YqVnaUOiP5e5Uid2MTFWogM+5
 Y/DgESep0fqHUrO2l5KEkRlzCwyz3+0nP+y5nbvSLWEDKSxn5mI771ExfsaQlhCg50BdPZm6D
 kH9R4COKSsSuHxHBlguExBslqhtHq269irO4F/LkcSaxT1V6KVuTDxaYMct47oERgnvBAeSg/
 zbiezAkK/TTxqAdXQ+F2/2KBWeEIfI95u1RpzUeH8HbmrfqmWfKLrd//Ddz1BQLDhpH2Tw6Tg
 a7XDNxjptsQmcukYxJcuwxvwX5KYyfpQSDpHg3/oHpPkfGetZlRDSMwMCMXOh0dk3LWCpsBPf
 3x7E7Avnn1V8SaXUy8c0raOStbjfzY/hk/3v6J/LoBOKPv6/CJ3suy0az8ayjixtZ5dpgJF/T
 SWm7/zCHORh69/jjv1ZPAAEID9cFLSwmpiiEicSI528nk8fO0mrzutVp336TFDzA2frVceQy0
 /tCa5Hia1YxIrbxryDW99+x8IqAmUqIqyH4SzLfYAO54OwBF510Lkhg2NxY0PYJ4B1lG5ebxn
 BxhTNye8MBHXENrJ4ZZtqHo0rmPnvn/FPHLLdVb1RJ2I7gEQxd+iwsuCdUqwdgXFf5X0QSIwE
 8aCA+IuoNJdqp/SPiD9IOIUINqkhuw5a5YJYiBezJt9hO65XwR7Wm+BTIOHl/8cUTPKnqLH43
 LMK6wazEdEUfzhmEOWcMZrRYkABuD7Dhw+15vslKcZ8d5nazkvu8BH+oEApwOkQ7EWScEqHiv
 3tdFuPSDaXheiK+QMn8K8vrVxJLGCnsTf4zwmIaw2BIbB6BHZ84pJKAUrZAAyVT55rj5humt8
 JwQ6TUvdeIkXNNIQPq7F38VdrI3MFxy2z9/CVoTxrwf6nmCZpeJcIOschAucWZmoup/sf6BAs
 pBQtfEeklHHf5qDmRAg+A3E835EBWVlZ7S5I/kIDq+9UqTAQ6hPFu7oxEcGs85QJZUzvXcvps
 +H98T5Dxfsl9reDOgDr7Ob+BNsAPqbEmlJSJdea0YwfPCP3ZmvdeRnOXIDESWnVNGmWU1NaLZ
 s6SgS5ZMP7GCvi6VQV5Nomch7Y/5rdt3wNTNHpso+F2h1c+hf/fURrfrNdr6zak0/qtqjSykg
 ZSNp2gUTrxBN4FkiV/0uyym9Do7IRuuxw1eTYJJDwPrScZ8ndgjtf+upKGGUstqEfp6kKPtMS
 PC/qkTpwMnW1aS0KCPvV/thLvbUraHbCYWZKcBgIdvjsauqdS6Km2WTZF7JbG+0uBsmOQDaAJ
 S4DSPcGeOAtQ3xeAZhSwGnB71rgxOVs+rHHZl5Vb6bhFwUCLo64UpNOEEX+v6Snm6ST/PshSF
 I+BBhPMeyTAgpQxvixBfitEmUTVHhaX0tb5Cbx7KdHw5n9p0hWODM8uqmsrJoGZguE0Q98xR+
 L9lbukBtzfzq/sLhxzjJnTpY8SdLufAR09yddt/xGHqdNjBQXm4KxzY20udRTbNib2qywEKAE
 AuY/IqnDz56DE0eJk9Qp4+lJXpYHvt5GOTttJ6lM9ByeDV1btw1b/AGRMAaWc80o2aPC9B9PA
 5V8JDvJu+KKH/+utlv5hrJ/GczW1U6rHMI4hgYlq8xTp7Fe5qG7WDVyOQ+QVO3MmIpAAtubBI
 eoi7jja0t44soOfChzFZsqGPYXiDh69N5BT8xHzvzvkB7/j1Cf6y/qY8/B43yyz3XSfqwgH1U
 fqx0yjX5yr0vQ0vhZU2QOpxsnmHMY3joPt3jzhuYL7neMyR0oaxFppfBFyg1b9B9egTXY3Zhy
 CJjPp4RwYqS4Axgj64tq4uk3hrb7o1t5sp7FH70i3bdooJ8qLZ4vnM56sJP4CIw1uPH4OggQc
 v5o3Qe2E7JXQjWLoMR2Zn/0jmoF8QACpPNAOYZPn91YL3USTx3oSjn6CnKf/9bRinuEAIA7Xo
 +pKf2rbO+N+yI/hWDXypGfgTgOq2zj/hv+VI/i

The ACPI specification states that the platform firmware can notify
the ACPI fan device that the fan speed has changed an that the _FST
control method should be reevaluated. Add support for this mechanism
to prepare for future changes.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/fan_core.c | 49 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index 46e7fe7a506d..545b490d624e 100644
=2D-- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -19,6 +19,8 @@
=20
 #include "fan.h"
=20
+#define ACPI_FAN_NOTIFY_STATE_CHANGED	0x80
+
 static const struct acpi_device_id fan_device_ids[] =3D {
 	ACPI_FAN_DEVICE_IDS,
 	{"", 0},
@@ -308,6 +310,49 @@ static int acpi_fan_get_fps(struct acpi_device *devic=
e)
 	return status;
 }
=20
+static void acpi_fan_notify_handler(acpi_handle handle, u32 event, void *=
context)
+{
+	struct device *dev =3D context;
+	struct acpi_fan_fst fst;
+	int ret;
+
+	switch (event) {
+	case ACPI_FAN_NOTIFY_STATE_CHANGED:
+		/*
+		 * The ACPI specification says that we must evaluate _FST when we
+		 * receive an ACPI event indicating that the fan state has changed.
+		 */
+		ret =3D acpi_fan_get_fst(handle, &fst);
+		if (ret < 0)
+			dev_err(dev, "Error retrieving current fan status: %d\n", ret);
+
+		break;
+	default:
+		dev_dbg(dev, "Unsupported ACPI notification 0x%x\n", event);
+		break;
+	}
+}
+
+static void acpi_fan_notify_remove(void *data)
+{
+	struct acpi_fan *fan =3D data;
+
+	acpi_remove_notify_handler(fan->handle, ACPI_DEVICE_NOTIFY, acpi_fan_not=
ify_handler);
+}
+
+static int devm_acpi_fan_notify_init(struct device *dev)
+{
+	struct acpi_fan *fan =3D dev_get_drvdata(dev);
+	acpi_status status;
+
+	status =3D acpi_install_notify_handler(fan->handle, ACPI_DEVICE_NOTIFY,
+					     acpi_fan_notify_handler, dev);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	return devm_add_action_or_reset(dev, acpi_fan_notify_remove, fan);
+}
+
 static int acpi_fan_probe(struct platform_device *pdev)
 {
 	int result =3D 0;
@@ -351,6 +396,10 @@ static int acpi_fan_probe(struct platform_device *pde=
v)
 		if (result)
 			return result;
=20
+		result =3D devm_acpi_fan_notify_init(&pdev->dev);
+		if (result)
+			return result;
+
 		result =3D acpi_fan_create_attributes(device);
 		if (result)
 			return result;
=2D-=20
2.39.5


