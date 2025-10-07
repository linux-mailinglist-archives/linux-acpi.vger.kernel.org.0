Return-Path: <linux-acpi+bounces-17656-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF0DBC2FB3
	for <lists+linux-acpi@lfdr.de>; Wed, 08 Oct 2025 01:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F8654F493F
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Oct 2025 23:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B27E26C391;
	Tue,  7 Oct 2025 23:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="ePRavnfV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BD3265623;
	Tue,  7 Oct 2025 23:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759880535; cv=none; b=Yp5/XjX1JWAkP0AmWphJa3NpI5OicpGQoQq47XWXZvOAv81QbVbatqq9pKe9y2N2Ggt0qAtjilDU4hiIc2cIT3RTBnlTFIglbLhpGkVVsRISbnkpTE4vbsQi/fN1jR5eQNHIBPNCYVqGNIvLHA8PSuVA1zM7HpELfW58eNSB3+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759880535; c=relaxed/simple;
	bh=2A1PlvROXJxuvTXphRZJjOdUQe9WUmSs/dXp8vOMRkM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iX2IdmOLg/XxsBXrQ+Qjn66cbTismAA8LBuHTv9ey18T5NRwnBw3bwObAiot+32DmN5SXc9uWE1Vjf2UkHJ3maQByzCeu8ieMTArQ7IuTUPvT7HLtnMkeukA6DjoU6UJkbJDb98xq/fznFLNnkP2yktX5f1UOKmc8YgBo1jmJOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=ePRavnfV; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1759880527; x=1760485327; i=w_armin@gmx.de;
	bh=pj2YF+0Jdh5zYiCsFKazbgJOjW41CP8/TLCkIbqm/P8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ePRavnfV4YtDLRrLIG2OJT3nRKnkJ1uTOOrkXEHL/3SSa9gq57SNWcXBVA6XkdCB
	 EViaDbGg/YsmLSwk503u9OtckPsFKWynLsDsw7DM+GTQJh3QjlGBURqZVP2KyosKq
	 FGXBbtTZOcFCNkd0XLPWplvqJIShRxvDHjkvoixq2IH/NdyWQ8uiXomFmUb5ZGhZL
	 Osf9kbwQjuQLyxu1WSaroGMq5at74DcGw+oxHUdwacm9ol54o3mHYDyC0xVKdPV0w
	 uZ/snv/93IBpr8Ml0LDDAAQ+iMY9Kooam5H9rsJT7/dPc9f08I/YFPSc2V7kCVspq
	 RGwR03iL8FXEtHZ4jQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Mn2W5-1uNHWy0q7b-00o95A; Wed, 08 Oct 2025 01:42:07 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] ACPI: fan: Add hwmon notification support
Date: Wed,  8 Oct 2025 01:41:48 +0200
Message-Id: <20251007234149.2769-6-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251007234149.2769-1-W_Armin@gmx.de>
References: <20251007234149.2769-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gXFVSIKCLbDWOCBvq60J3bePbiDFPsmlELwWBcxNsWNg3zB6WOX
 jd8fr7mPf/ZRC8sNHvRwHun7dr0HllUaPx5JqKcbM+SCoMXkJyrAwpSsobF9oSzNXjBI63u
 HGMqqOBUCShx59xQRaiS7gwnIkb2UKkkZswXmP4D14yk9rZ5d33VEWiEl1SySK4GOiR4xpS
 dbszQohzag6UgGbt7QIBw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9noA5HXASkU=;mOTAPochqo3oP1zx7hU3A0eESji
 eMHvrz6MRoSNXFqrkzCCScFSZFAhg3qFrsW373dJPT16uTLrQGPCF5ZFMp2JdZlGGMExXJ4Kl
 sILewFK9AzkWaeqHRx000R6wuEnZYeQxmNEu+21KwFgdR7pu2ZesFJe1b68iIyz7EtctW+pKt
 Q8Bbi60GTVXdxgVbfOOx8m+1ZbPQKmUQyo5+u4VzhdRf+yxG8YM5P0PqhrTdYVEkQNRpLcPzi
 FABIswwihIcQd8HBY56IT/Pr0VUMvfY7C4n5Rxqzs6XXajk+8WKY15YzVMno60MCY2frNXlmK
 qjibGCQ+RZlv6JtNE8VPLS5FRjLid3kI9WNxn06lDBW2wzkV4CbO0lIQdJQab5gt2CWHFn/QE
 P75zj7KemVrj/zEuTSzihWqs8du1K0QTnrKJuOpj/CPKqfnwkFaTC4cYHBKK/QqpCTdbBy0x7
 BYYAhDAv3veH7MXaccP57hWKUeQLYVLrBG8gpnz3wW4ptTrRQHDOgY4fAhMRlwzYeOjI4ztnM
 U6uSdVpDonFRuXLCYlF8p4J0oM7PKM18T+6lZiks07s1BuTgqAuUrXwWR3Nwh4dNXnef95BLv
 kbPA7UT+7wauz/fW/Zg9jcRgSVP6NOG8XHkG08T7EuxHyHovsqsdQlcmL/IO7mMkYsCAc3Wzk
 zxNEM+5joD7gePEVwZXqO7qYwXSbx/79nsuwrzvtAjnPbfTrr5zMDTykZqv4CUx38RJFUBBp7
 NOJ7VfCWjIxoP6lNWqumNSCycsxUhkEPwBDhNmGVKKAzEZvIR3Zh+BI9yI1td77RfWixL3kPd
 NwhyDTPVRysRjGxVsC5trQF64laQmIX/Opz3czM4K4rhfdGxtp6ARwhtp3u1mtGZiaDcod52y
 Q7QgiYiYw0R0h6fU0/3Ry8Gr2jYBqun63rLdgWaA9yhalerEMzyb443M/V5cG3KClI7OYVzwJ
 oktiJwf1knosSnEqhzhcrzwToGIgh0YEBHwyHxB7WeFrFeXTTKYhvBtEO8ukC4zIHwMUOHS6F
 eOmgQ2MEtuOqKCgpvJ/YWJGkjy/QFy4bm8Cn/unI90siFEbZX9aO7mN9Y/uE3Lsd1W7ZN7kWz
 y5D+FHEDtK0Sgv7wrykbPPMpRmd7EH9EAQyeUQ5c0W/FOXMYZS3vjGyL2XCkl7idsD42VpL5q
 9v5yhKTjxOTeE8XTEj0GP866LNiVf2X5xUAuD3cnDdT8ZMTZKAYghZftNmrTzKd5QZetcUYs7
 uD9swN0dEaC2eL7JvIJJCUqgJzCIvSAv9TR9HyHjUvUc0nACZXFeT6ySd13jM/p7z4PRJFczv
 +8SKd4gxRbSBdQ+BRi4LDvZbBiIv4DRXxUm7FKJ4pYsg9ZnZCazOPZl2FhHSEEr1Zq+ALQwF4
 yBMdTqAyHxXV/3Qs7WEf/69qD+FkNwDmGz9qMUhNYL9rKCbKVl8EATU/Z4QU8ry1Vu0+FBiak
 jzM4bA6YvQGvOqJoqaHm7efky/U371O76uAAhXiTaIcoqGzZDxsE6RxbTk9PK6L+OI6UiqOl0
 ZftBm5m4Mw3mXLxIH42Qam39eKZ0hgExp+usAtT7QPymxAK/qEdnF5q/Dmv4qH1gNOv8vo3jd
 86KnET4kzl2u5UL1h3aSUxc0VMdHXXQSd8cVHJR56yFJF+uTwT68Rb1R00r6lTCjkfNOxsMTY
 4tO/7TxAvOkRAgzRvCxqgszYdQdaCLgRTzQJQsJHMfAGBGW/jfu08WMT3AT88pBzHJBY0ukVm
 19X9DjjzyLn99WWkNoHys3e2FKQigAuOKiG5GsUJIpiln8dbYvTnhXSYnm5fbn7fItnFkSrKE
 aoIaWqofrDajwNnr6u15Vutlq1jVKbbzqCL2up5DCn8g42+tcct1f0nXUwfUcmfBhwS2U6FpW
 OxUGOgC0bKy++0hzWKS+KcAEO3UJmLE7MRGY4WYsgLUti57ToiHgV99xgT7PGfRrq+s4Ef/hF
 JIVAu+5jvbHDBvC0g6S9MX5kIiyJ1dQS9RyfBUMj4oDoRXXH3nZ2wdDmDlPI8CagTwud1hZmX
 mtAFodkjaEgAAn7WHsiPlkdhOG17sRSgtmJK9p82LQxSIKlUSVGg4VTOu62DMNaBJ39XPpdei
 M6hxw2yYRV8Hyc/G0eZlsavcQ6jZPMEC3OsmSCwH927JiTz3NBrQ21pt+lH8ILNvjG8ygGQvx
 CBA1Czxbrjh9p9p3+r5Mq76qBuMSm9gE9DzDhFNZClQr7MabGjC+KgLUiJOKBTgIQ/RJcCfBF
 MnorIxppoFsJFgEpMGxu/bgf3Jb+kp1lRdTx9dH2VZEnEqQ+LLHXQgA0MeBeXUDvsKbzidt4s
 GaLqSqlEIZuRMutYeMHXFzTN8AD4MePEx0x2YABBZajg2npUsKxVi/gik+gK5/pE9zlrXECcw
 RbQ9ZAYdTWw9Lj3dngpl/XNDP9RcUtVkA+T8sdPnafs4c0lQbyjytfL3hA6W37zHCeRF4gdGe
 MyTeCWEL5SaSiMQV/TDRQQ3R2MDzL2DNayHe5dMfofD/7XNdG1EYledMjctKz3kPzUkrtdCWh
 1ntV8ZAWurtK+ufbAh/JhAVLztC0bcdwNrvLgxPsgdkRzv6wnSIQIzioB//rDwNZJ4H+xUamn
 sBeaTQQ0ULixkSy/LPfsnoJGx5NUf1/cjx6ZaoHy3TMTcKp88dN+yUNUHU+JV7CK8tltpp8ua
 neTzgalnx6DYQiiT3aVQj58++xXr3AfSPFO1cthlxi4fp2nCM5TBiejxWKOAX/8henHvWG3Ht
 VqcvaCWDBZUnuMLlxSnlOvULLTHsjseMl7VrmN7pON5enMS43J/jQ7pLz7WQ6KZWH5BNZsxyA
 o0VHN2ly6aHMetTmT48JLu9b0zgIWfFoOZ4Zs+byVx/lmwYxdhUUQWLPbrgZ8eEXcrCkdHwoG
 fKJ6L18O3DHj5qffnwjuVQ1PZ9e11Vvrg9qLQnsCWWyb/gu/y0F7shMimV+SCAO2momC4K4xY
 DEH3V8JGg2A6as3VOl1aAIYe27F0YO7JwIqeQ75Fjmwr+KuhLqBwU10EmCEwfpK87cEj+E5bj
 KiUkrG7/b7n+7XGMza1/1HIRkqJAU+e1oRYWlfHIfsuNIQ6nicAOmnezXUfpffGVFvxWT0tad
 jdezRXaThRUlfrIHul2jI0zJdJpBU8UQ85u8THMnV0O9sjEsGuCDEMXKhZUw6pJ1MTgcbvgle
 vW0UuwWGj63Vrp9jlw8SmdrlpX0CTn68gNTCSuYDl/uQTif8Q8O+a1fLXhljG9H6zrmTNaMM6
 LXz3/FWC3kMteJ1cPyv+xEyFmESNTlE31RK6zlZXylcTbF4Axpy4i9Wb0FHTIzS3AkB95agh9
 vUAt9f+kMNb6A4XVJVnUNtrEwK6KcvAW3aheWXBu02WAj8ZiMUHbMrcuuENSNx97p3a2XVAKv
 GBegheL2LkyWSi5AmgFuo5IyXOKxlaNYn49+ckeSkLmHDzcPhUAPsWrcHaiRmqnac/dQG7Iaq
 84+FlBEAxTAWYWbHUgScZfeUIUbl2zsiOSILTgsi5E1iYeuwOZu3qQMPDEKdJu6Sgkeb4spOL
 +HoqeMNa2ZCwNstjXXbQuZXFNSIadB26STe759yRyANP23K6V6Xr8/CH3bTbM7XAfs22k53OB
 d99fSfrc0GZrVoWPPbFUw4gr39AOFBMBrYogj0bybSki2ib+gB7eFJs4/iy9kbKkNikDfw7Pl
 8mVboTPDyTIrnDFxvvy5b01Tmpma6FFui43Egkx0C02F7Zn9VACJ24K6n+Es9VLlPR2DOPjUO
 99cfYi5H5cTB/GqVL/3YlHW8ofhWpVY+QQvwx6h+r9DXqnzXTMV66aCG5r1PxNKSpmDdNfwo3
 UzvaXFwFaZuCQ3ierE2GqgxeFgqeFsBALTfz6sXWfL8QfYBC4Uatb1pcDXIeayUufcjFS6Gub
 LcxFx2ZuSxoG06LX0+bcKImQxCvNqhs8qX7ywKjRdQz3uxTl7N/pa7tuaKvYEPKaGThPsz0u1
 C7DPtmrOOeawGxh+EixfUDYoSlNe2HN0l/ewdLfkFmWen+Zj4lPqPGLY5Tzhvu2H8a4vJ5alg
 VjgMIumTdDM5RsI9TWv3ZZvneNrVp3g4qYfQ/XS5HC61qeKZ7S9+0kJhbauA0qpyvnGMzbOvz
 AWp57qiq3XEsOl8dQalVwNYDu6Vf+9961HYzPjk8FEbfk4ZU2+c1rJ7ZPUGXMDFOPmMhgQUtY
 h+LzLZT6eBSJ6+Upa5oIs7MrPmRh9SNQzBgdK8AG2JTT2HMBypwd9oHt1DssLWuVHg8poL1Gy
 gWW0P3HgJuaEfMvqnz6bS3htx5+EBsyxp2SLpgl9CZ6UTTt6vsZUs3C005i8Yyei8a5trLNio
 xTd1vlZBapLKbvE5ts3KR8YRCNYBlzxrPaNFkNPEKz/znjibngUkVXy4aJ3Ast00siuYk1wy0
 a61dUDKFM0DnW+JxZ9R8I81nVQOoIapKMNvVldh2UjFwmaKOXBm6EYcyw9wdwe29LW+76j5k+
 DJsAIsy769dGhKGO9oZY6AsK795RCsnoRC/+NSUpc18b6htMHltRsCtcP3c6J9xAeyYruvjDh
 yX8RTprKw6w0V2I69zhNK6T+GyDx2bvskIkzICJ4dfT4FeQC856IYBPL/DB/64tiIb/JLt301
 wheuXW07+PS4D6g1TKbCmEwWWYblxnLplXsmAZE13Oc4BofFTOOos0gcBHvaoirM77sDefWCH
 BwP38t7VaEAeENYfV30RCOPSBKV2V8eHfKqb6xauCUijQ24qn+UDBATr9AkNJvfy2QLo0mNaS
 1E8Baoug25BMG+ZnQgM0uXGpESholc/tQ0oCQIGAMxyt1yCZcBnDjIXcHk+g80AKxdHGP4vpw
 Bshas6mqMLt8w+2m7Y4H/+KLonlMTu4y3SKcKpPwL6S/nsADaGAC5bzJC2iRjtjbjWIbZly7W
 b55vDHmELNheTW54AHgq6DD9f4CmJv4WUiStHwoWC38c4+YBTOLe1+A73v1hKy26leZuQXWu2
 Rz0VucyrvcwFsPmXQsgcovWiK5FuCs8L6Vt6Xm7HNhd5J0dNwWtAlsh+SMOjt5sbd/24k3RkG
 W4QrtbS5zQIUH0dJmSSj0IE/cA=

The platform firmware can notify the ACPI fan device that the fan
speed has changed. Relay this notification to the hwmon device if
present so that userspace applications can react to it.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/fan.h       |  5 +++++
 drivers/acpi/fan_core.c  |  1 +
 drivers/acpi/fan_hwmon.c | 15 +++++++++++----
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
index 0d73433c3889..dcc1ad3118ff 100644
=2D-- a/drivers/acpi/fan.h
+++ b/drivers/acpi/fan.h
@@ -56,6 +56,9 @@ struct acpi_fan {
 	struct acpi_fan_fif fif;
 	struct acpi_fan_fps *fps;
 	int fps_count;
+#if IS_REACHABLE(CONFIG_HWMON)
+	struct device *hdev;
+#endif
 	struct thermal_cooling_device *cdev;
 	struct device_attribute fst_speed;
 	struct device_attribute fine_grain_control;
@@ -99,8 +102,10 @@ void acpi_fan_delete_attributes(struct acpi_device *de=
vice);
=20
 #if IS_REACHABLE(CONFIG_HWMON)
 int devm_acpi_fan_create_hwmon(struct device *dev);
+void acpi_fan_notify_hwmon(struct device *dev);
 #else
 static inline int devm_acpi_fan_create_hwmon(struct device *dev) { return=
 0; };
+static inline void acpi_fan_notify_hwmon(struct device *dev) { };
 #endif
=20
 #endif
diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index 9ee4ef2d6dbc..7be22c52670c 100644
=2D-- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -326,6 +326,7 @@ static void acpi_fan_notify_handler(acpi_handle handle=
, u32 event, void *context
 		if (ret < 0)
 			dev_err(dev, "Error retrieving current fan status: %d\n", ret);
=20
+		acpi_fan_notify_hwmon(dev);
 		acpi_bus_generate_netlink_event("fan", dev_name(dev), event, 0);
 		break;
 	default:
diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c
index 47a02ef5a606..d3374f8f524b 100644
=2D-- a/drivers/acpi/fan_hwmon.c
+++ b/drivers/acpi/fan_hwmon.c
@@ -162,12 +162,19 @@ static const struct hwmon_chip_info acpi_fan_hwmon_c=
hip_info =3D {
 	.info =3D acpi_fan_hwmon_info,
 };
=20
+void acpi_fan_notify_hwmon(struct device *dev)
+{
+	struct acpi_fan *fan =3D dev_get_drvdata(dev);
+
+	hwmon_notify_event(fan->hdev, hwmon_fan, hwmon_fan_input, 0);
+}
+
 int devm_acpi_fan_create_hwmon(struct device *dev)
 {
 	struct acpi_fan *fan =3D dev_get_drvdata(dev);
-	struct device *hdev;
=20
-	hdev =3D devm_hwmon_device_register_with_info(dev, "acpi_fan", fan, &acp=
i_fan_hwmon_chip_info,
-						    NULL);
-	return PTR_ERR_OR_ZERO(hdev);
+	fan->hdev =3D devm_hwmon_device_register_with_info(dev, "acpi_fan", fan,
+							 &acpi_fan_hwmon_chip_info, NULL);
+
+	return PTR_ERR_OR_ZERO(fan->hdev);
 }
=2D-=20
2.39.5


