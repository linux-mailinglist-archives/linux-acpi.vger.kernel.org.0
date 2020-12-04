Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624A72CF55E
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Dec 2020 21:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbgLDUPQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Dec 2020 15:15:16 -0500
Received: from sonic302-3.consmr.mail.bf2.yahoo.com ([74.6.135.42]:45436 "EHLO
        sonic302-3.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727175AbgLDUPQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Dec 2020 15:15:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1607112874; bh=YfdJmkgyAelV91TRnp6plxiix9tzbdDcoL6irU7Kg4w=; h=Date:From:Reply-To:Subject:References:From:Subject; b=S9soSQD8dgkRcnWrDP0QhTqw8YZa4TDhkCg+Bccl9Xpn5W9oB8DXPqHfIRfCcte/gJrEfpQBasktWpqfFxSta3ovQ5M1o3togRdaTMccUpNsfI1YFN5swvZhLPvoBAhjkGddiX9ID1RNvuSv0cgbAbaKiqDOhSJ/mr61HpZaTFGx6gOsXA7qRE+x7b1W0b2CXcKJlbDiYnaR90O+QzsXQm8GkzIBsJEDJ18x0ld0UDGB/bZpZC6XtE2XKrhPazZ68FrYDpvbt+FWImsZhH3azd1s954+nx6d3JCNTlT/tiSGFZkm/8N3+zASewcLpTDeCfUSqL6N2l9FaN/6lq05vQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1607112874; bh=UtDNmFGogPMThnFphE8avDlqCr8wXdYV2PKrk7w7uzV=; h=Date:From:Subject:From:Subject; b=kXCx35ykHBdKpHnnTpH4baF/IXIcMPPZM1EIa/fd7YCRbBUxCnwDWRPJNYd6RmxbrqWiF3zFWeIZZKju7MhiKeZykaKPJd5kZc4WXoiFWmYEYryaNwfH7eBYQ5LKNj6ttkLfqXq0r+GGyxjIs67skA7cutBxBw/1pYSW8jXzAAp98fEZCywfNzOjuP/k1shLNEz/fDnd0xCKOFY9bD0Sy4z2VBzrt8oBFcfKKi0cdwQ/k870MdNe/Bg4VDhQe4S79qHp25UawandMEgNunkrTQvgQpeWI2+LKQJ7/u/dN+52kAvd+A2jAJDY8Rqp9OTNNRCovNdn+aPhI1EsaPsVxA==
X-YMail-OSG: Eu6C4zkVM1n50fT3WPz8sF_bMHHs_aB4q6r9XGJShMOvk3LNWMrgD1DfN9UPuh1
 XL_y4d.W43eqUtkFEg5_MD5bwmjaI4Ij978ftzAQWpQOCq1pjiS_aT4VbBxlxUpbHfe_IjzNah.w
 UE_3zlywR.n2_tXA.lhMRU91322ND.jeInvCnv.12nHlkFbwjlP.o_rb0.fzVAraN_uquPSJSgDo
 BzM88uLPERYa3VVglqZrrZex_FAtsgbto6THmkN32AGOD8FH7tySuNOLbQVj5b_6uwGvDyDiXjwL
 N6nPlZL5C_vqqDGnkrE_RIeRTLFXk7LSoeaTfkaeg8V.bWvTrs8QYBpm_sMrHzSTth_8OfojJ9Bz
 ABXtrGiPSEAqXt8IDNzVmvVh6ZNtv3XYQHnFThii1oSqLbZ6BspsUMDOp5OZMTOqX0PRFAVF.94f
 73SG2SU.eEK2GDLLxRomlJfHzAhGufOKDp9egSLdMuQbAFcIDyWKRlu17cHhe3chPOQDzT5vOYNW
 as7SDcbWnzdkw6jKX0ZYpL8gN8_83oxAtmR7OGJ.JyWrXSNxZVnVKB9.lMt_aNrcpK.7_wXDXyZy
 x18FNyJpwichghjZDcJbKm1i9sCHe7eOtmXQrZhFgBn4BsDOUkglw5afZj_Sg1pjdpGvTjWMYbOC
 AcOzEbxPZx_WTC75zj7qD.QGzQ7vv6D7eYoD3eSI7LdFDQGKJdTJo5QUZNuShQcyAhoFvosT1ttM
 q_75fQXdRqw9gM4jxnNkbLWKHdi5PobkyFAZ4I6vB8cuCBqyTMP.br7XA2F_SHZkbZZfi4PC0May
 B3jWj2ZZSht3_OG2JGdeaqZqqg17jXEehWTXITfEmgcPZLvGLpKcozCb0kahWFPUwvkHCDfjFKFy
 t9wx6.OUbRxyLVejcl2BE6yAh9Dqr4uHMlvqantBWGPNCAQutyEB0hLc8MFaZz4OsE23lkyDh3mk
 A9f7D9fPNU5W0Vp4uBvjpQLBH9UgWdf1fR8frfe_SApJJxl_CzrXxK_9yrXHxsrTtbm4Luwot19S
 zD0uzEnErXscYxiBQRi4FXngOqw_l_xpbN36AEa0a.N4EuMuG_67trEPWFRZEByW5VjAXGmd9Dyi
 bM6OnWdFJQARPGn4fWcE4NHJlbd6DmcYHWVh2KvqhE_NgXNtJuXAUHOZLvgjmCxSKln3i7I0A6Z8
 iVjy1244onxtpxeQZMFqvLb.lJfezhdf0RzXiotfhFwIsBeaSL4G6ZsFb8kF3AvFsytjuWXmXQTQ
 ApCGhSo9rA7gDEHac76RVSaoPKiXBccL9DnBQsfE1k0WUNv2J9DmDwsC0PM1sHPm9l94x2u826pp
 MCT8T0R2sbKBTInHgbiSrmYeAlQZW6NbMc2OaKfnpwvLFhC4tPekQURMulI7VbCWVm.UAVvgSgLK
 o8tp_qGe_CmP_pg3brfJNgvMJf_nzJ_qnzOwGO_HPtqhOCaS0_z6AflQw8k76Lml0kECMGXcjl2f
 eTWI9v1_pNlvpwMWLb6cNhAtiStUV9W8a6ZIjp7.hwXMF4XFetwtSPg5f0Tw1Grc_7XrJTJLbNkQ
 7crXrPP6Qtig4Wg3WLUsh1JM7O4SfrQNwnxytbV36ki21ttOoHUNR2D1pcuW5uLe4e5IZofwu1aH
 PDcWfBTgoNI20n.U.JG_HSIT8P7MhlkQZjFh.6GPN6U4CiSzmzpBDLQy.xoVMvHCbmUn3S9IWtNe
 rm9CyhoSDBIxPX7xis29vkqRmLAveDxB5Qun5W7kZ4QirVWzlF9vlJFmECyKamUixgI_D0svyWbI
 e9TKM8gIRAV_NonyY8f_RsWRN5985bJD7xcIGdt87E8E984QQlSQPZLDmy91A2sTtiUybLyojgsd
 ZKqtNpP44C4A1ZRjGqbI3h3XtWrZCcNY13q08P76VCSpH_Cqs3GEszav20Xy1.Mi6kkbxxBB6R4q
 FO8Ge2xamHgr9F7HQQusgcD7A82j0ul0cB2BDfWOT6smJ2ng3FgXIdKdCqJc.d5M.a6HRBKwyppk
 eLuf3FF8.ycsyuieh_B2.hmaix33Yji1BFZsiSawvS4LQwIy59F7o7zYVKKZFicysNGyImWVevSO
 d3Xj80yWHGCY7OeNsU9a0HXgVO7SXdzvldaSVkc.WT94BiIOJw3kJV86VngzJ02eSIby4XLXTsYT
 Xod9Ue4i66VPPku5JW7izLnyxkJC_gFtqTLnhfW9MdAbE_q4tcI_Chc3uI1Ev_N8pYJ8_OnzFLSE
 DDWCgBFhfx_TAeaO0BBiMTNsaOrSVyAZyUR_fm3bufKYxLtUWY4dOjbPU6drTTgdnefaUuMvNfKs
 0ItYDpfBLtZ5eI7vLiBIY9B2GG2qzvCqA5LGzKkmVJNapij58sTzxPODQ7bv_1xsWwMd6kAj3Qon
 StDsq6w7TtIZ9Vpg.ocnuWNpUxAF.wHBK0d2hRLoiG88e0o6K70HjxsduMBJ4l.SExJN2rWMtrJA
 X.Qsp8xOztPcNwEt8BIrI7OiviWguxw8e6VXkjDvfaxqZI_uKj69D3fEKmIsuZkn6_2yUhNV4FpM
 ymLj_TgI2hxYq4ZNIAA2QaOvJGS9l3nFPgAux8To8ho8_0ccNAvr7qyBUcJygFuT4xAHoQemX_o5
 TlnSauleDvuHPQ.ZCaE5JrMluCoaahzi6f4fIAJl_vGD2HGqZyJgKDGKmLsWbv3vS_KPPL3GploO
 GhYU3tIoH0AgCZkyHZ9SkxUpdFuUqU4EA55M7iKk0BLlJL60B5e5KCY2WGsZtwl6b3ys4Lj7RcLy
 EzwI9LWEq.eOH2BMP0C38mLd._QnfzY1l3jgcZYYJo4RZUOr7SfUHuUetLK_V3wkh626vMtzrY8H
 NJZE3W_CDy1rOV._FsIlvcHpnoid5jYiNwxkBXubtn5TrCLi5Rd8CRKvYKZC48K7hZRbssm1u8Os
 1zPFMvopY.VXlaHUjgMzDYfTff.5T28mIGxg0ykN7JBbZLb2OqZM_9u4pcwZDZ53MrQmNYQ2jb8G
 OljspFQ_O0Ybc4k72kYqBygPGd5xwUZKT_F2LLBz6fUrEjjQIf_G3qoAIEZXwDO.DOeVnNDjrJbk
 qxhQ6ecreR0e5P1k2Da49dUIuRhQCl4AjrrSLe6ysm4L.jieyGaWGV1wpbNrt0dMViWXpTmMHO22
 cL2CTeOkN7lnVQ6CHwQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Fri, 4 Dec 2020 20:14:34 +0000
Date:   Fri, 4 Dec 2020 20:14:34 +0000 (UTC)
From:   "Mr.Mohammed Emdad" <melkumyangerasim0@gmail.com>
Reply-To: mohammedemdadmohammedemdad77@gmail.com
Message-ID: <1047570822.2908182.1607112874045@mail.yahoo.com>
Subject: VERY URGENT
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1047570822.2908182.1607112874045.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.17111 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



Dear Friend,


My name is Mr.Mohammed Emdad, I am working with one of the prime bank in Bu=
rkina Faso. Here in this bank there is existed dormant account for many yea=
rs, which belong to one of our late foreign customer. The amount in this ac=
count stands at $13,500,000.00 (Thirteen Million FiveHundred Thousand USA D=
ollars).

I need a foreign account where the bank will transfer this fund. I know you=
 would be surprised to read this message, especially from someone relativel=
y unknown to you But do not worry yourself so much.This is a genuine, risk =
free and legal business transaction. I am aware of the unsafe nature of the=
 internet, and was compelled to use this medium due to the nature of this p=
roject.

There is no risk involved; the transaction will be executed under a legitim=
ate arrangement that will protect you from any breach of law. It is better =
that we claim the money, than allowing the bank directors to take it, they =
are rich already. I am not a greedy person, Let me know your mind on this a=
nd please do treat this information highly confidential. I will review furt=
her information=E2=80=99s / details to you as soon as i receive your positi=
ve reply.

If you are really sure of your integrity, trust worthy and confidentiality,=
 kindly get back to me urgently.

Note you might receive this message in your inbox or spam or junk folder, d=
epends on your web host or server network.

Best regards,

I wait for your positive response.

Mr. Mohammed Emdad
