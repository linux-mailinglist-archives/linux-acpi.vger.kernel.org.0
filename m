Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 757E540B411
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Sep 2021 18:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbhINQDY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 Sep 2021 12:03:24 -0400
Received: from sonic313-56.consmr.mail.ne1.yahoo.com ([66.163.185.31]:40208
        "EHLO sonic313-56.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232916AbhINQDY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 14 Sep 2021 12:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1631635326; bh=5CXpQJfaCXlkXFU8nPhjdtiipAoidL9zCC14fhSj96g=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=oQ1phyinB62iD6YafSRlUay0KWpcp9r26Q/zx2nrH6Q/5gcJVF1z1YwUVmwpGWPO+vs2CObgeL7A7ldgmpoLAC24EZBy0PfSlBGpVpFamsDk77xQfDt2T+UmMPKHFpal6Lb2z/cbGSO3JfXS6Ww0AdHvOwiKZo65EntBWqv6lJfyzeomZCguJfFw5w52VDTEEziBLpj0zO/zly4LjmIWVreUxNIhpZ/ICP2BdGx2Ag1IFLMozOYSccZTerYhvUCdkcYDFfEca5hkIlH+uJymtUC+BvdbCJ5gi8mllnSXsTARyCQLXIRfVs5xLTztr/nYJGfacmRJy37efGfRfliChQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1631635326; bh=VCUAKbkb3l36KX/PgaODtOUj+HrKJWl+/LD+BTLccW2=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=CStq72HXNB5h2thvqtTMNnOfJKYWPP9Y+YtdvncYtu50QMG3HL6BzTDdMEx7mKMfWdPC4miYMiAkpXZhZyda4z+Djv/x7uPzAdAcmKojZ6jnt73umtdUGX+JWCT7AZPbrbqV0p3P6kXSzDnOJjH6mHUev4PTNZOHzIRgkoYLt06A9tGUzRFCMugXNIaQ7SsOuW6oaI2AXXR9+pF0oeJBHQ870lgoL+AEWPbBVbtVXWVf/0ZIiPnU0S7ddHdxB7zbUN/Ae/BKQBfXBKCN0GAqw1rf3ysRI/xczMDR/KB2hBQ+ImwRT0BIGsP7n2c1cOIhn1j4rS/VRa97cl5pNvwBRw==
X-YMail-OSG: zEeb7KsVM1kdmWdPeD0q8Qg.J5X4hJatsqbW3MM0pvlDpLpZ4c3Dl0lJ01b_M5M
 VZ85KETd4oIgag_PR7OBUnMw0kDoCTSXJeCt7SoutvPPPiUPpEwjul2jbmcOi2sXYv97sCPEM4jT
 3sJUckl4Vc.s_RWAbqHcFNTc9zSQ1z3uNuPwgZjWaNKUkN4xf1wgYTlTJpzKYBgWnptbyNu7.QFY
 ZhNQanInrTDE.SYyopOthz6UKh0_GZe42j6U9MD9LfoFZ6tkBwIjIZhrlwh4WXzw5SuDkaxTIv4R
 jIkMUpVTozX53wlZsKAgWaFSca8oKOzxascGRBOHp4c1Hu615mrMG4MZlxX1P8CuARxwcRQYdDG1
 XtojSJtsXDrrdip5amG4kCvlJPrmqVeh6YzBb.VLg6Nu3ddaUxw_22kCikhJoMUOCCmM6XVGs0D5
 sdnUX6Avr1tC3fskQ2tOa3ccCPOn9qsrnaNAoT2RstJpdCmDZ0fRqfI1rX2CBDkRa0xkhdU03yKn
 UANaNsRT_Krvyt1KCwkFly4Eo4jfzc6MGU4ysHPFhNJueBqScRQsV4TEQOPrT7XtDenlirwaWbfj
 eTfW6PX2gsDDKy2cgCn2jURtXw4_c_wnjD.La2V3qOI4rFmgnaTtzpba.DUW0JteMjbhntiI5Xrp
 EvNzW0f8Juf8N2VG2.n6YchoqiqqDXJzcATi3UXbpPeg8RB1b00a714I9YqqDE8eFHucyNfOBODv
 85GvQPEgC0DFapbirUX4FWaRuxV7SyRYIJCiTJEdyzpm2x3LZUd73H2wc_fVAkIPAaqEtifmGT_c
 M3dTWiSHcbHJxLr7_KQjbt8utztiWWiRHVRjukH9P61tU37WWjLrzr85roMoFsplpJlKXBP8d_0w
 oazcN2PzV0yXag1ABbb_OmJrxX4HSc6X6.XlaAMmUvXfi3qw5vWk.ynYInNL5.IYyjsXGlU6m7Ps
 .1TvIN3ZTWVc717G4WIqokKJdIi5WIqJK7e.Lq1iwyz2OBROu9dDABOvPjxp2IfdNZlhDyTTxlSV
 r7Nf.33LWL6wDVeNRoOhyYtlSb9q8Dfc3Bb0xUv5lCZWW48j_s8DNZXtQBB8vlQEsk5t7jJ8mpeI
 kTLSN5E9Qit1lZ031_wz80T08H7zhbSfwI7i31h8rDis1kDUlDTeWqGJnGv7QxdDP2_bATFNqXLm
 H3acWWZSu0KN3sGDV39LiPvJ5ppdIhekKZ6kCdwfylkrPvL4cm7PXFFl3Q3bCPvmRAz.tuiYUK13
 8Jg_CkmYAfbON_OlgvjHLpA0VaDzqVjGJuoDCk82whlG3Lp2U_nAbJEUKHOQ_CfFHxYzj6byFtE4
 yu6RcOMZuJ_4F702GNVj_F47cUbShjNFtxAgPbDaDrqmKJMIsv80bzBooT8PBSJNPFu4hWlMBGc6
 Pxm4.SSt0i2D4EVqrVG.oXTQG5bk935B1wPFu7OH6OOC2Av7kbuEGgfBDXPpXxndBZovT2d.dtpc
 G0oKnbIS6lQYLda5.vlELJDELg7olyqdVnliIAaA1346KNNvQMUSDa5VI1o6u.XIRFDhsJDttcox
 ME0ez_dDNqY1iqgSF5hOZSvxBQKHB4OjiPz3OmgjKcH5d87quQev2ZjvLr_Ouab4HvGb6mac5isl
 mhbhSOFjStM8Cys7h7PjFgad.iW7hW56qtl2sXVQm8utzefQSPb8RWelUZZRSNF5r.ZDlTkhABHz
 EZr3_CRHiBd6Qq5fqKnLqITv6veRzveE0Tn7FAAuzxci55LwZXSwIJNHyhfW5a36mymHhjy7hwNv
 RdZMhrPi9WB8YuKyLzEmiZyaP.1PYaciU_azlJLDrf5ZAvSIY7Ar0SJ_17NLaRoCmEjxfQRWxI9s
 k4cXPL2nnTjaMnX7tEvf_emVdUGfpap7GwSnBfqwWZO_9Ixa6rIjFphq7oew_t9R20lrQ1Xo7g70
 RwkPDWY8TNozraGe6yqoFiur4YrtrwDupkxbxLH1T1VaeGdTg09YfdpMaLouK8AxrSCxHhIXIBJv
 AubSCWPWCMonIEqwJAzaWblb2OoqbAkMc7CzNLzaOjJPO_sQmNpJ.qG37V6B57LLXw5p30VU_pMG
 ME0WWQEHsyBIb6forrq8MXhqVQluNuP6R1ALGvBLawUoVQcchB9LMUj.AYeIBgSKfJoKkLm1EwXM
 dvLVkqlW1aeJNvWfmOieewJbDad3NMawnTQ2y4X_9ocLqlKXgAv4YjaARdBPsUf8SSMAtgAOtDJB
 5tC3ezU_V8F4ADwhwfKB0Fe2J
X-Sonic-MF: <manuelkrause@aim.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Tue, 14 Sep 2021 16:02:06 +0000
Received: by kubenode531.mail-prod1.omega.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 500651a8f7c195290cf737b93fcb8eb0;
          Tue, 14 Sep 2021 16:02:00 +0000 (UTC)
Subject: Re: [PATCH v2] ACPI: resources: add legacy irq override exception by
 DMI info
To:     Hui Wang <hui.wang@canonical.com>, linux-acpi@vger.kernel.org,
        rafael.j.wysocki@intel.com
References: <20210914133410.88366-1-hui.wang@canonical.com>
From:   Manuel Krause <manuelkrause@netscape.net>
Message-ID: <dffc0f3c-19e9-5b24-e33d-588e73ca130b@netscape.net>
Date:   Tue, 14 Sep 2021 18:01:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210914133410.88366-1-hui.wang@canonical.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19013 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael, Hui and all others,

thank you very much for your time, thoughts and work, again!

The new [PATCH v2] works as well on here as the previous one. 
Keep my "Tested-by" attribute.

@Rafael: Do you see risks with this patch or the need for further 
improvements? If not, can you, please, push this patch towards 
kernel inclusion?

@Hui: Are you going to publish the updated patch on bugzilla or 
should I upload it? -- Many thanks for your recent quick actions!

Best regards,

Manuel


On 14/09/2021 15:34, Hui Wang wrote:
> After the commit 0ec4e55e9f57 ("ACPI: resources: Add checks for ACPI
> IRQ override") is reverted, the keyboard of those Medion laptops can't
> work again.
> 
> To fix the keyboard issue, here adding an override check by DMI info,
> this will not affect other machines and this design refers to
> the prt_quirks[] in the drivers/acpi/pci_irq.c.
> 
> If we meet similar issues on other platforms, we could expand the
> table of skip_override_table[] or medion_laptop[].
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=213031
> BugLink: http://bugs.launchpad.net/bugs/1909814
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reported-by: Manuel Krause <manuelkrause@netscape.net>
> Tested-by: Manuel Krause <manuelkrause@netscape.net>
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
>   drivers/acpi/resource.c | 51 +++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 49 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index ee78a210c606..676254ccac4d 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
[...]
