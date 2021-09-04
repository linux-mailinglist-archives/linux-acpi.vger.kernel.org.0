Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B762400C01
	for <lists+linux-acpi@lfdr.de>; Sat,  4 Sep 2021 18:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhIDQFg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 4 Sep 2021 12:05:36 -0400
Received: from sonic301-32.consmr.mail.ne1.yahoo.com ([66.163.184.201]:39408
        "EHLO sonic301-32.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232298AbhIDQFg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Sep 2021 12:05:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1630771474; bh=Pv14aUFPCFdsfUBaXy/vmMoipNRCdMsTtYizxgSvil4=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=DA541JPHF4u7OcdtPc6u01hZEg6LozzL/Zy3jA2jd7bc4VntloXWmxYsEQd80s1ge1BCDfUQlQXGT8m/bfAv5oSSEtF36kp/rL2SYMV0wCCkd/d7I7Xgw7XCk/jY9lc/rUekCThM+YQ1M/D7WojNYbOFUKFZmAgLoND9wuAoOyeQrdwcw8gyy+284ZCHOi45zwLljg3Vh1SeNy3tHwFURHXzfi+pI3Z5eKkiHBq/TbuQTSs+qa7ZkKFgfkWs49tcyJVPVSarwpdk4waaTub4uOct28jclpi4qsq/pPjmZxvLqNFKEbMMbVfP0gd09OeU6G4tYIZUd4At9p1gSEXiZA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1630771474; bh=goTIPZLC4SypwihY6srnPFAM5h6Z/2AFsOn0hZfjkZx=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=UfFAZQTexbAf7AP48GThQZupOmLzd0nPC0Qe87oLleeNrTPvhI8LpBCOdSKNuDA1X4msyg5JWfB6kk4mAWJWfOxWAdYIyyUxx1xqj6Bo4OkaACGe7gus7psPTGN9kgcRriigUznAoG9IKqRxLJYVTe+9NoJCzxpntHLGH0zwlgf2QJewR/Ww6aJrsLbGtwFMv7hU9g/MIArwQqxpPRxaBOoLj0IPWAQz7FCHNxjmNKsU0Zv1/uYs4sYGX0v77WZuF4HUckmnsUCC9KLDG82rWOdc7yrcfLuR2hi5dkmmlWmpMTtXRHb+nyzwXMw1azX0FcmOTLYwbN3bYwbRYVygLg==
X-YMail-OSG: DEGLT6gVM1lEIjoZODwqAyhpZOnwiYKZXfVQTh1JLBTxfvo.X8XmMFqZrE8hkm1
 FB7XjrP0qMow825D0jzLG2OmCo8M_Y9zkN.bq_y5uV.Ckf2O6sLDahwIq0bFvQCq34yij37v9KDY
 y6oaTEkjNuqj.5AkW9dTdNA5.QxotpL2Kt5OpOYQqVPQY3WhpxFM6mORzbslqI5ry.qUswOs.hXl
 fZJTFAlaGBzSOTXuMDnL8wWo1RhGGb590hkKsWf0WLReF0Kv5q4BmQ1smuVV8F7CxOedYzJ52i8e
 sxxs_yhG1J0inkQXRqg7vabFlAsHWTQIM8vp6gIyzanb2rpANN0IkY44qXjtoH0Kt.HsfeZmIq4Y
 4u6lU582Fs9j743iISD_v5jn6axGiCNkhyDjEz9vKm7.yWDyRuquZeULjDJs4ImQHnoX2WrQOOcY
 zwmrbevIfHxjKECvn40_w6SQ82HL7WqIIEmeEx2N_2gjAvMaYsdlR3IdJlrOwILkQwOVJaAZEomC
 jvCjOxjMD2K22_vYTXveof1sjD5W6qYc_u7KmB73zH1ke4y0NI_lxRn0hNEWeDkNLINg8yJT.SYp
 OP4SDWpns4ysPZEMhEjixTyAFxybYNVx1.9czuOiOoAeq_GSTZ3L9.W63n3C9RgQem10dbvPnBpk
 Wan8E60Jb7xWkeDAOUqVVsO036YEYJxjGdJSOw3aggBW3bc8c1_2dRniFIMmKlP.jhkzy.TVhtpe
 Nuw0UBUD_JcUSZ1qQ_BPCIKJEM_pkjJRlHkOFRPDuO9VcQJSJonKF7tR_FQkxZVosqq9IhxgZiqf
 iTl4krdN0pPKG.WBQh4UQ8BG_.rmhTs4fEsSjYNVFcfJ86l07rbhsWSSCaCgTN8RVmW54Cuzagb2
 4YdnpJdT3ueN17TYWg1pzz6D1wizCpAzCWIPkNMXeJNRLqe.y52jshpXechw2beck0KHoEPZ.NeW
 DQuBcHlMUrtdU2xeuHH3AwDHkoi_Fp7TGSJ8jdp.U.sMNWMawPw9e64t2hRd7.FLHJ9tm_E6vRFE
 scfahz9rBgvXtFdG.glGNHrSQUxa3tI.656ndLx42crOpXeX.9pxehFo_m8iZypc4N3q9GT3Ymrg
 zgM5c3e5dO.U6UGYR.lARx2GEMh5_PnrYLOvaORpNosNXtwN2AHthJu9bid1NKa3914B.g1EHKSF
 ZYOn.3PeYhnK11mfir3FoNrq6w_CkThKDJIwKE1LFchmesczClIWdvp10x4R.lY_JrjCZ0w5jhlj
 28Mh1DEXaFQ5zpMZ4Zex9LDwURWgEwZENdvgqsg314y90m8Rq70dgD7008t5Z1rLgdd3_puERxc2
 26n4UA1Bju.aC2DYXeedw0CldtJgWdDIL9_9d3HefqK58afTkJ4M0aHSC.T2EIvpHuFpeFK9ThGL
 wDIlF.r0f.Ca1xQGmvMvsA.HGCRj49tMBtSA75lcJ6zE_H9ozf42_7TtpJLahBDDqrLzLKXnIM5b
 k_mm3Yb6ungyMRYe4hu61U59D_csbWsXKgJ7lzM9.1XO3Rv9gUJC7ombg1XMZxGUl7f8buaXM0XI
 lyYNXUtnzPZyo7WWIg_dcvfGPFOVnEmt_50IXAmpNw9NZlN1aMZB7Q5OSBsh6fMxzZdi.re8NPDE
 9Odf2TFyd7yL7GVgaD0fhyP_ixCK8T6BQ8dVrx5RZ69XPjWHg0La64YynEvxBTr8D7mXk9WuPti6
 DXha1c07pYRvRzhVFBLenjIGdjt0PN0tglt8B.Tfqd2h8.QOhrGkNzlCKnvi36X5j3JZgdtoaMx.
 kSBC5PgkRF01lPCZxns05fpIhaHe.G46ogSryS.Vp1Je9Qmso6KOjlcxEWwKAzIkw9e0E5pMC6P1
 tCCWL4gf8jVLY0cA77KhNwk255rJ7rZF5nVz8BF7tmICUwDI5cYVrQani4yBYKJbbqdNuvneX_Nv
 o6W7WvdJgasZ9u0wroHP.KElgwxJ5YORdM4GfUDK0tdURYfNd4z4q2GCU0R6ZlYSNCGp5NFsPcsC
 ikh51dtN.bjGMxgS30MvH57Xy4P5E5RSY.MOE5tPtrq_Yx0Y47EQTnU_8flibKNGUhzkFu0wPt9b
 yyKATZSqfwb19PK319vLUfLbgC8XD4tTFPw1fNm8Pnmy_wvebVuQ7BM01sklaS3C5QSAnNAOKlC7
 MvC2AJGeuvDFYS_6rPNnCrbTOUtmgIaXwRMw6ERcVSm1ZOwv.gUff05e3VtQTRdF7KWHAfXA84PP
 ZMNVHPuz05WXsySzGeFa2FysZam2xCaXcIUXv8KFWw5m9Cxow3U9J
X-Sonic-MF: <manuelkrause@aim.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Sat, 4 Sep 2021 16:04:34 +0000
Received: by kubenode524.mail-prod1.omega.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 35e580efa75b39edf35871231144eadf;
          Sat, 04 Sep 2021 16:04:32 +0000 (UTC)
Subject: Re: [PATCH] ACPI: resources: add legacy irq override exception by DMI
 info
To:     Hui Wang <hui.wang@canonical.com>, linux-acpi@vger.kernel.org,
        rafael.j.wysocki@intel.com
References: <20210904014340.17536-1-hui.wang@canonical.com>
From:   Manuel Krause <manuelkrause@netscape.net>
Message-ID: <d34e6ab0-c8c2-6721-af41-09f04b6030f6@netscape.net>
Date:   Sat, 4 Sep 2021 18:04:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210904014340.17536-1-hui.wang@canonical.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.18924 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Hui Wang and all others,

thank you for notifying me and for giving it a new run for the 
kernel! ;-)

On 04/09/2021 03:43, Hui Wang wrote:
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

^
| IMO this is the major positive aspect of this patch, that it 
enables additions, allowing the kernel to work-around other buggy 
BIOSs / hardware properly in future.

Maybe https://bugzilla.kernel.org/show_bug.cgi?id=213353 "IRQs 
for onboard UARTs are not level-triggered with IRQNoFlags even if 
the parent section has the defaults in PRS" is another candidate 
to add to the table (but I haven't digged deeply enough into it 
to be sure).

Many thanks to all helpful people involved,
best regards,

Manuel

> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=213031
> BugLink: http://bugs.launchpad.net/bugs/1909814
> Reported-by: Manuel Krause <manuelkrause@netscape.net>
> Tested-by: Manuel Krause <manuelkrause@netscape.net>
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
>   drivers/acpi/resource.c | 52 ++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index ee78a210c606..434c8964f182 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
[...]
