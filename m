Return-Path: <linux-acpi+bounces-21480-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAvzJGKsqmnjVAEAu9opvQ
	(envelope-from <linux-acpi+bounces-21480-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 11:28:50 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A76E21EB4B
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 11:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7C8BE30072BB
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 10:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FB137C90F;
	Fri,  6 Mar 2026 10:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YZNrFYMs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hqQCY3kp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A47C37C101
	for <linux-acpi@vger.kernel.org>; Fri,  6 Mar 2026 10:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772792888; cv=pass; b=gwgpYdxgJmQUneye19XLokMDXhKPdASRfF1Lyik8YMeFWmGIyN0wM/heH5xWsbQhUJP5yLPxxgA+tRksuju1Y5E8IPhO+U/h28rL5zVDuVOeyjBTtlRwjbII4gLDn4yvdeJRIOtbVrUwlL5BzmLJSfYEo187kxAlrNmiX0hh9kU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772792888; c=relaxed/simple;
	bh=tdvWNHoSdu2Iafp7/mrEBG/G+46fyd5oPjPg3sfvUEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QGE3r26SOX/zi0X/cg46J2+ZdCmHWCjbOqqq1bPKliGEvZUZ3kS7POnNMBGNBAuGxaPeZyiJnMDYXcDABi0IAIxQQwsB00TP7GVZuJWs7NbWpfgS+IYPJsMozMp48vH335FGqKNnyudMpUNDF5s5fc3extTOSc9w82LpYE2krAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YZNrFYMs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hqQCY3kp; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6264alKi3886983
	for <linux-acpi@vger.kernel.org>; Fri, 6 Mar 2026 10:28:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y9h7Pr+7iqUr+8V1CASot1k/T1Bc+EXpK2ZcBTLqhM0=; b=YZNrFYMsk/Fkkusp
	mx2tkNw7vXOuadXBQCGBDBUTlnpr4NZWNentC4QFbcG5JFgpAt1ePFONSVn3deL1
	du6XPuHnmNjRjKozn+7yp1KVO4GZaLcJhVStbKqzhRv6jX3CKxlmllys+4Hzatey
	JliSi8fTmWxnYIg9oOT7O3uCq0cv5Jri9G5kxjq3+xcNYylT8JoAnL+RjcsKgw16
	/Run8SLGv4x8IrgXOw/d+NvubpqD7qO6zmjgcukTczcfqrv9Zw8Q9k2STjZkcRnt
	HWfPzwo+IOH3e4ul5BaL3HOs5xN+3QhnD3tMo+cIdjqsEqso8ZuPjOWrhJrKndmA
	3Yz0vw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqj4sa96h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 06 Mar 2026 10:28:06 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb4a241582so4629963185a.0
        for <linux-acpi@vger.kernel.org>; Fri, 06 Mar 2026 02:28:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772792886; cv=none;
        d=google.com; s=arc-20240605;
        b=NEChcHZL17DyG2vHbukV1onTOh7ZQoaMhV2B6fkC55+q3znkpQ6PCTKuP8zMybns8a
         nSAIEUdFtZcbTEh3V/C/VaZIMOHSA/P5guXMBep6DGvgQVM1CPNLkp3mJsx+eSqKML6Q
         2uR6wS82SOjUOaBCSFChBcsuEcVpQl1EV/vBPsyl0got23RAMKUvO6tsmljNipXAB5Sl
         C4bvbGqZMawbQZwNYcff1mJC64G71OMNgMeUr1ZNHmcHhcoCBxgt/3vgG2cDIiymzeCV
         lHvMMSVuQLfKP7evzrXmJI/I3fMg3G4Kxl+TEqgQ7yD3HRDyODOh+VILUdzCqPlxQHF0
         NCtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y9h7Pr+7iqUr+8V1CASot1k/T1Bc+EXpK2ZcBTLqhM0=;
        fh=wh6HeqEPAUQFatL3nS9Lvs/YZRsAJl9oGRsfSDrXaWk=;
        b=Hs1H/AAzDajhz03s6qbhihxqBmusagKKG4QDbOfn8YDR3mIuEDcjmJVOcgLi2DiXCp
         PkX6jHperFpHcOLI0kt4PmPNwS/8I83Wf4egH+6W7A1HV8R2P+ZYOHfMZGV6uVjHI9tf
         T9haW67C3rJ+HnmAr0GQEebVEqu1vKEvzFeFiiNvRk1SA+XEll5EVOLOu1/4jV8OGjoP
         bOARTMvxzIZUJot3KCbWzs75Iy+lEp4Aaf608fqPYYNYlHO/veg4Osn7clnC8teG8MkS
         7KFav5Zw1xlnBLrtD/WW9RfcQydJOzziQrR4exrni32S0UIpsgwokzliylmzNUhFtqWv
         pFvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772792886; x=1773397686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9h7Pr+7iqUr+8V1CASot1k/T1Bc+EXpK2ZcBTLqhM0=;
        b=hqQCY3kpeVfrhRqcdnBdQtoIt0bdj7JPMGsmT4ROUjwNslACtgOzPUwP3T6y+jOGIF
         3LC1cMCswfoQcmfIeqihF9Ky9rHF2L38LUxV/d6YM64jYQB9JPvqT3EigQUOtdOW6JdN
         Z8YsY/9tMQc6QkkhmeRlpiI7iZxyHdwujwFU+QgFpScXnAFYtTnxcE8lNkbwfLyoXAvX
         J8Nci+W7Tx8yyldJVmf1ePcxtADHC1+0w5uOTSHP1tDh5ZRhQXhYRdeu9jcj6AC2PPNb
         6/9DFbfJ7mV+XMBYnpk57sCu8+LgJbMcYKtDXeS2OG4VIyUZLLRTUNcdCGyabBNLVflA
         mNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772792886; x=1773397686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y9h7Pr+7iqUr+8V1CASot1k/T1Bc+EXpK2ZcBTLqhM0=;
        b=W40UkJfNKhtcGCgfCeH66v6QtGAVtCmQjzP6iv19BLtEZUmFXYbzz4Mbdqgw5BiUnf
         t89msxM4Notu6P/zZ9utF0FJiKL9/9OxfWp0S6+eqSz2QVUWhCXjmnWTPn8ocBuZAL14
         LlJcaBoEkrPCqNc8YOMMdGGKr6e2kQsrisD/FFyCDCtQE/VJ4E3M7ZLa7yckIBALIGE/
         dDFoeIGvCvsu5Fcrdefpdk/t98B73XlfKF5q0H9lqGIwvD2EhJfzGuqvezf3GJuCiRFX
         iNuk6q12oVSz2UC0HwNmGUXgFWIuqMhVf934CWchzvvExN/5fYb6ASK+b/TU0hb/0+BR
         77Gg==
X-Forwarded-Encrypted: i=1; AJvYcCWQkR3RNf6C0zC0aYSfCpzGDxHioiljlf0QmzW9H9C9iCSeIENgYVA7CBGpxx/9cErtOFWguUIst7Ii@vger.kernel.org
X-Gm-Message-State: AOJu0YzyIINDir4Lfd0TJ2NMnl+mneW/CmbjIpEOvGrDvz69Z2ZZq/46
	HTP3WE72rpHRjKgxoF0PpU9DIelAJ0aSxNNDcMusdWZtFnTkEnmyjLJfCjSFJJatYBeHQjJusKr
	emOPFDLjM2zkkP6HD8mMv3w/3iBOMY+maZ93pZvGhmIairzxINBIWJh7/vCIAIGa/QM6NTDNjZG
	q9NDhPpsExPjfLb2UU03Eb9BYpIb4k1/xg3QxcSs4=
X-Gm-Gg: ATEYQzwPAexezYtPE79b/uQ68Za14nl7HJlty5fZLax3m7YEkA5HCi+9B2970M7bT0M
	28z8aqQqAH3SE2bRYSqzH7xyVahff9Tv9LvwcJrlpttXbnNuVK9OGV1zb5wq9i0XgqCY4WWnvK9
	kktH6/K8hkDv5LXnnM+l2kZmy+11atmvFM84udbrp+WRQBDIcu0go36JvXHO9KGhcQdH/ZXqLY7
	OzGWyQ4iCCZb8bnNlbwbtVG/RBj88rW3Si3Bdw=
X-Received: by 2002:a05:620a:25cb:b0:8c5:2f36:660f with SMTP id af79cd13be357-8cd6d4afe58mr161743985a.78.1772792885474;
        Fri, 06 Mar 2026 02:28:05 -0800 (PST)
X-Received: by 2002:a05:620a:25cb:b0:8c5:2f36:660f with SMTP id
 af79cd13be357-8cd6d4afe58mr161739885a.78.1772792884906; Fri, 06 Mar 2026
 02:28:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224-pci-m2-e-v5-0-dd9b9501d33c@oss.qualcomm.com> <20260224-pci-m2-e-v5-5-dd9b9501d33c@oss.qualcomm.com>
In-Reply-To: <20260224-pci-m2-e-v5-5-dd9b9501d33c@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 6 Mar 2026 11:27:53 +0100
X-Gm-Features: AaiRm53iYOytG8xnHxV8VVUSUeAKgAc5EavTdm2RyqP-mIqV3qUo5jYkbTQaMc4
Message-ID: <CAFEp6-02wcaEYr5BJvqMgtMD6vArLghvw+Lh-YE+OLXyZa-i6Q@mail.gmail.com>
Subject: Re: [PATCH v5 5/9] dt-bindings: connector: Add PCIe M.2 Mechanical
 Key E connector
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas.schier@linux.dev>,
        Hans de Goede <hansg@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        "Derek J. Clark" <derekjohn.clark@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-acpi@vger.kernel.org,
        Hans de Goede <johannes.goede@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA5OSBTYWx0ZWRfX8CDGzLB973Ks
 uIBI26CpBQqXhwOSz0NbkvISO2YgkGhaeV9IGTGU2JY/rIsz3obSy9+YZwKZ9/kbIOvtjpfPWnc
 9SvFe3Jaal2doFeMe4jNsjhhI5BOcdyVfFEtxcsETHK9mE6gq/2eR17ePjd3S+0C8esMORr5Lv6
 rqrUETbw7Okmr5MeEpDMA0kJxuX5ePMndnFPuv0fc99kt/cyL0b0CgoAEFDXuPVU41sl/6dDthW
 2brX4gFK+c2+64Se1XNMuoMzSf1jes5hBUYuLOsfKkRN+QGvUM434FQZIkz4zAIphJ2062bUrtU
 Nw71X4WV7wmbNugNcnyGsPC4+B6nxd5t1+4ny8LGEK6xxuEfEzRL6ec3xwY8/PL3BgDoK4LSqGe
 /vP2QKUyfJ73r0tG3imlcm5a5UdQeikUYl5qFLwAFZf2KlE5ycGc1vKhb2m75r5y613knNlXX+A
 Z9/XaOXHnLLgTw9tdbg==
X-Proofpoint-ORIG-GUID: QZBh6JvbwFzRFpEco6B1XpSkZ7Tyo3h7
X-Proofpoint-GUID: QZBh6JvbwFzRFpEco6B1XpSkZ7Tyo3h7
X-Authority-Analysis: v=2.4 cv=T8uBjvKQ c=1 sm=1 tr=0 ts=69aaac36 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Aq5ih5MREXdaAn1MBKMA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_03,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060099
X-Rspamd-Queue-Id: 9A76E21EB4B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,linux.dev,linux.intel.com,squebb.ca,gmail.com,holtmann.org,bgdev.pl,vger.kernel.org,linaro.org,oss.qualcomm.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21480-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 6:32=E2=80=AFAM Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
>
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> Add the devicetree binding for PCIe M.2 Mechanical Key E connector define=
d
> in the PCI Express M.2 Specification, r4.0, sec 5.1.2. This connector
> provides interfaces like PCIe or SDIO to attach the WiFi devices to the
> host machine, USB or UART+PCM interfaces to attach the Bluetooth (BT)
> devices. Spec also provides an optional interface to connect the UIM card=
,
> but that is not covered in this binding.
>
> The connector provides a primary power supply of 3.3v, along with an
> optional 1.8v VIO supply for the Adapter I/O buffer circuitry operating a=
t
> 1.8v sideband signaling.
>
> The connector also supplies optional signals in the form of GPIOs for fin=
e
> grained power management.
>
> Tested-by: Hans de Goede <johannes.goede@oss.qualcomm.com> # ThinkPad T14=
s gen6 (arm64)
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>
> ---
>  .../bindings/connector/pcie-m2-e-connector.yaml    | 184 +++++++++++++++=
++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 185 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-e-connec=
tor.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.=
yaml
> new file mode 100644
> index 000000000000..82dfd776d480
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yam=
l
> @@ -0,0 +1,184 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/connector/pcie-m2-e-connector.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PCIe M.2 Mechanical Key E Connector
> +
> +maintainers:
> +  - Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> +
> +description:
> +  A PCIe M.2 E connector node represents a physical PCIe M.2 Mechanical =
Key E
> +  connector. Mechanical Key E connectors are used to connect Wireless
> +  Connectivity devices including combinations of Wi-Fi, BT, NFC to the h=
ost
> +  machine over interfaces like PCIe/SDIO, USB/UART+PCM, and I2C.
> +
> +properties:
> +  compatible:
> +    const: pcie-m2-e-connector
> +
> +  vpcie3v3-supply:
> +    description: A phandle to the regulator for 3.3v supply.
> +
> +  vpcie1v8-supply:
> +    description: A phandle to the regulator for VIO 1.8v supply.
> +
> +  i2c-parent:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: I2C interface
> +
> +  clocks:
> +    description: 32.768 KHz Suspend Clock (SUSCLK) input from the host s=
ystem to
> +      the M.2 card. Refer, PCI Express M.2 Specification r4.0, sec 3.1.1=
2.1 for
> +      more details.
> +    maxItems: 1
> +
> +  w-disable1-gpios:
> +    description: GPIO output to W_DISABLE1# signal. This signal is used =
by the
> +      host system to disable WiFi radio in the M.2 card. Refer, PCI Expr=
ess M.2
> +      Specification r4.0, sec 3.1.12.3 for more details.
> +    maxItems: 1
> +
> +  w-disable2-gpios:
> +    description: GPIO output to W_DISABLE2# signal. This signal is used =
by the
> +      host system to disable WiFi radio in the M.2 card. Refer, PCI Expr=
ess M.2
> +      Specification r4.0, sec 3.1.12.3 for more details.

Just a small nit: according to the spec, W_DISABLE1# is intended for Wi=E2=
=80=91Fi,
while W_DISABLE2# is designated for Bluetooth (Key E).

Regards,
Loic

