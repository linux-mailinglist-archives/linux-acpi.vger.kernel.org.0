Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAEF93A188B
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Jun 2021 17:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbhFIPIq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Jun 2021 11:08:46 -0400
Received: from sonic316-20.consmr.mail.ne1.yahoo.com ([66.163.187.146]:36169
        "EHLO sonic316-20.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238135AbhFIPI3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Jun 2021 11:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1623251194; bh=FGa6ToFukF4Y4hGFYVGZYPaErFlO7Y5aLX1IHH2H7Hs=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=nxKnWi6wgiZ+tlTveBFz4glQ17WrtTSeE2Ml2cKOfMPeYhJkQMP2PrwgPGsOgUx988Aqgekmyvs1ixWzIw6s/yn3yOFkty1/p6Z75vn9nmEKuPKBGmUJHGbbuZP8znKn/z1qHiKI1GR7dY/CFikX3OubGRr6SD9yJuIvzEc5N+7rFw2XPk0tbUCrEroqMtknFliKJnVy9HncmDHI+bNPN/vNqSzUnd7BO7Icj/LHD3AC4MXbPv/NUI6nWRNa1whpX1Nfzq6m1jkC+H0IgWWvmYjlsFWR0/1HhsmW2rU64yjr7RgwKfvK4VnuxyGiFqS5czuLBrqRd0cjWZOhm4rblQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1623251194; bh=sSqqW2UtpHfRZNEcQTYlweKo7Apy6UEiNg+WD9Y2snW=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=tuayJm0qDkSOfL1Rl9RGifzujYkz1LlMWpFLdP5aZrGi/EEgSf+N6Hp5eZzd+oC2R9KFUwkzdMQPExXLPwl3DWLrR21cc1Wo8CPcvAJnI9ESB4h3pmWD1F4W+VG2E0s99iWIfU8a4FilaOPOR8PgUH6LdE5syCy1GdjD70ZmthM/Q9JHMJnR2uvgi8iQA0z/WrnMJ5XErwYdnDhSWYkHXP4A17OGtwA4V1ZYvub4PzkVTiftJixPHkyLtOqlUCipmbQLTqQKkzSLlGQpECAkkv0yOYoYWyQjuFND5pOUs1WABwa1Dly2DRy2vDC8Pb3fP4xEOANNRfwVFnDbe1AQcw==
X-YMail-OSG: EkrVXboVM1kxNc7afk8GDJmoJ5nwPM_HaiIQ6fX_s0K.pErT0wxpRST_CN8mNYo
 8u3lHt45MI0fo2WO2_nxnWnrURrks46_Y2z7bAp.BU05uhAEq0U6EAVGEMI4M6ph2GGl04lEB2AS
 kOjzSkGDqsLpNOCx6lqPC9Huquvk6sxNeSEPyeo0r74Q_Jrmt1p2Ysjz88Cd3MT8bwz1IlWvYDgQ
 uV2zWeeI1NkQ5O6sQKzgwiMXHtpGMKL3CguEp0tBMJPZG8wkjUzk.RDt_88FOaN8mOyASdZ8lMVa
 JI5vRU5i6EDp.Clt4PSuz7el08mA3vMpUbTJdjogvb0hPMCst942nxaXbjpX2_V430ooBCXpjtfc
 9lTTkvmaPBZ50kkJOXaVgJln1j.uRcW1Vs6KMfwpyTZvDJCCUcY6UpG016_ZPzBTseqeIpbu.rBS
 2Maebqn4OK2xvtxgrtFRWTiSBTYAMGlbJIWAjcsypF.hM6spbQtlbwVdp78YuqHPdtdTL8FjVnqI
 JyRyzVh7t4P9qNNeePC5pvLjacp04x2Crcmun6QR8tgKUnrAXFqZcE63I0mUb3I9fvmFy1pIM7x.
 .paqEE2BXKONH_MKo9CflscsQ_7AvIJMlwQrx0TQIEaiE78zpowPO8esLdVCgY_Buq42GOOEBVgX
 6DlYZMR0ubYknoGE8WKlVyJjbimDiYDpMp9Rv5LieZffehTX7zPYib2SYTP9i7B6yhd565nACO6A
 THcPP02COEaNdwZDbU.kf4Q8soQ9096Mgwe6Mhz6u1OnUlbPSARsUY19N1fDXB2235QQO8wvjmj1
 2PbD49_oDBWlaD6pWNfapTjPmnj1bkOFIL2GcqEWA_r.rvisQxEjtLwaIEfW8TRW4tD3Gf_36Pl2
 GFsbiypBHRrYaRlkzSdIQOH_ohCdrNxuRKbJBuTCQXOQ_WHE_AezO6mIpSSsznQq2szf_dBsZOO0
 bL_oNcL2zASWmppTBmRNmSlvpUt5CTqje.YFLWVeYxcW.uo0BgDnDaAwnah7Wknn2oiIUyoV310C
 yuZf0Dp7dMOD0iicuv2L6f6iMazOR9SaC6xQfeI2PdjBaQ8ZWp3KMfRhl4kIcSdM90w5QW2aC29f
 7AuSNl3pVa.TD9yYbkeaBxQmSnOlp6oYN2cWG9KAzkn6.Hep3ENyC28gcktgn1iVPhYewpZ56m_2
 nohOM_pHUU6KNhg.E_KK3.4pgKRwZkXZR.e5Ly8tB8MiMLi2qbBq8eJrHHsOfLq6Xt9AVflM27ox
 Pp1YxPqZl7Ijk8autLKggeRv.VAvvhbGXI5V5ZGgCrieIduTeftgzc0VoKkF9wfm3skd18MNHUxF
 Qpd4yWkq78k91IKDAXnJJnSnA13QvUirMgmINYnM.6heejn.s09z.Ne0699.sSFRuW9zg7KUf.BU
 lXw1FGj2pIim8Rv8rNEFh89ndc8eXYqYsb.b4OEnkB_RgfTeyS7tj9MMnhurtuCk3rSdigneleY6
 5gQgRm4nOcy3gOhgUw0wNESwrhskAaJEVkvatWhp2jZp1ykxgI6CQSvfCEyiL34kSqusN2iaEZbh
 AzPxqd6I4iVllV_NBGP.FXi1IJCwB21Y4aD33GchBto4RLdFEjwS26y15_o8kOLAlO6LRB.pmjza
 lGQ2YyS8j6zkj9F9btWnofJxp0PgsfmdzeC39VspSR__9t2gWDvgchp1AbaiTusBj07ATx_o5JPH
 Vhg.uzjxGE2v2kLsq7H5c74qec2DYwYTQnZ9fWc51GPi5LoaUeb_abOPCMD8YxFuCNdY6MliXbgq
 x.5oP1B0fUAlo3kCY5SovtRdfyA6TUg4absb6i.EVd7DVGU7qjcSYQGKjLtbgoBrs3T1zKpSLEOs
 WQmzi4sElJgDaBllTqQB1EEBwcQnYAOEDSI_DWxJO.O2YfgHcTwD9Vke.4PFgR0p3E5mmF2w81cC
 EzqrjNZTOKXlA1PMmt7H5Snk9Ve11hPSJMTsG04XJ11cYpgoilkBgmPWcT04Iu3XcYRJytJCLJbA
 heT50BseWTU8oYazxc5k8QJD_.QIIkew5mo82a8QdajLMMPBsGpR2Y70u_hI8DZhstv6vMyxFUj7
 GQnSjQkpAFyApYR5taDtdv1gOLa80z_qvWiK.IBQzTBm132T0XjLi_Tj9qBEtMrac40samBkPTDa
 YPXTip0BvZLC309hYJRT9Cx6BU_VAogZh2RuYXXYKh4DPhLNQnfDaJ8BsaGACjTsPIUEMAM5NFnc
 WcVGtyu2olcsDBwtruAqMzf.RM.lMcqNgd.VTZXciR9p1CavVUeMqhMsfI.dUsWB_NcXNfYsVF1x
 0XjTIziQQKILQi36d04g3DgAq4TzZY.Dfpg3fwdXFHnyBi9oNWk.HQu4_sJA_DhhdiAbmMcwaTke
 UZeUYwWRrj9iW69HhWCSU4RBzhFbHRYvHn5BRl3jb0z0cv1Ei2QzE9TF5aQ8cYNZ0BCLSTjJas9T
 mwisl46P78S57Eo6I8b59xTUaObXNB8wp.e8eDbiaUi_zT3wn970MO8Pyvep_htZcZaLw0hP6ixU
 e95qvA1iKs0U4t8s1jcz9RDML.5WiN8b7xngnuiWpxl9LWHbLOWk_B4JxZ9Ai_l3XF.4mrzlS8ac
 lM70RrYwBnRKjjMDYuOAa70KB3ccuCOckBN5QwMZUHHvQW5zLykgXPYRyQIG6RhuuqR0opZ45adG
 pSQxzQkblnAl6_3x9wl2LMY19kzi_T98PT9yLDcP2TuiXoNyZeZY9Ob_4ol7g_edeptVAKUm57oM
 i8I3n
X-Sonic-MF: <manuelkrause@aim.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Wed, 9 Jun 2021 15:06:34 +0000
Received: by kubenode545.mail-prod1.omega.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID b16d5e1ac2ebbe1eedea2f206ac23dc3;
          Wed, 09 Jun 2021 15:06:29 +0000 (UTC)
Subject: Re: [PATCH v3] ACPI : don't always override the acpi irq
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hui Wang <hui.wang@canonical.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20210609021442.12446-1-hui.wang@canonical.com>
 <CAJZ5v0juxLJXiyreAjeNkUYZZ2SHWCdFRM+ip3-H6NrgYHa=Cw@mail.gmail.com>
From:   Manuel Krause <manuelkrause@netscape.net>
Message-ID: <c704e5b6-624b-1d92-a2e1-e57f13d9a38b@netscape.net>
Date:   Wed, 9 Jun 2021 17:06:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0juxLJXiyreAjeNkUYZZ2SHWCdFRM+ip3-H6NrgYHa=Cw@mail.gmail.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.18368 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 09/06/2021 14:44, Rafael J. Wysocki wrote:
> On Wed, Jun 9, 2021 at 4:14 AM Hui Wang <hui.wang@canonical.com> wrote:
>>
>> The laptop keyboard doesn't work on many MEDION notebooks, but the
>> keyboard works well under Windows and Unix.
>>
>> Through debugging, we found this log in the dmesg:
>> ACPI: IRQ 1 override to edge, high
>> pnp 00:03: Plug and Play ACPI device, IDs PNP0303 (active)
>>
>> And we checked the IRQ definition in the DSDT, it is:
>>      IRQ (Level, ActiveLow, Exclusive, )
>>          {1}
>>
>> So the BIOS defines the keyboard irq to Level_Low, but the linux
>> kernel override it to Edge_High. If let the linux kernel skip the irq
>> override, the keyboard will work normally.
>>
>>  From the existing comment in the acpi_dev_get_irqresource(), the
>> override function only needs to be called when BIOS defines IRQ() or
>> IRQNoFlags, and according to the Section 6.4.2.1 of ACPI 6.4 spec [1],
>> if IRQ() is empty or defines IRQNoFlags, the IRQ is High true, edge
>> sensitive and non-shareable. The linux ACPI driver (acpi_rs_set_irq[]
>> in rsirq.c) also assumes so.
>>
>> Here check 3 conditions to decide if the legacy is true or not, if it
>> is true, it means the IRQ() is empty or defines IRQNoFlags and need to
>> call irq_override().
>>
>> Link: https://uefi.org/specs/ACPI/6.4/06_Device_Configuration/Device_Configuration.html#irq-descriptor # [1]
>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=213031
>> BugLink: http://bugs.launchpad.net/bugs/1909814
>> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Reported-and-tested-by: Manuel Krause <manuelkrause@netscape.net>
>> Signed-off-by: Hui Wang <hui.wang@canonical.com>
>> ---
>>   drivers/acpi/resource.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
>> index ee78a210c606..dc01fb550b28 100644
>> --- a/drivers/acpi/resource.c
>> +++ b/drivers/acpi/resource.c
>> @@ -423,6 +423,13 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
>>          }
>>   }
>>
>> +static bool irq_is_legacy(struct acpi_resource_irq *irq)
>> +{
>> +       return irq->triggering == ACPI_EDGE_SENSITIVE &&
>> +               irq->polarity == ACPI_ACTIVE_HIGH &&
>> +               irq->shareable == ACPI_EXCLUSIVE;
>> +}
>> +
>>   /**
>>    * acpi_dev_resource_interrupt - Extract ACPI interrupt resource information.
>>    * @ares: Input ACPI resource object.
>> @@ -461,7 +468,7 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
>>                  }
>>                  acpi_dev_get_irqresource(res, irq->interrupts[index],
>>                                           irq->triggering, irq->polarity,
>> -                                        irq->shareable, true);
>> +                                        irq->shareable, irq_is_legacy(irq));
>>                  break;
>>          case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
>>                  ext_irq = &ares->data.extended_irq;
>> --
> 
> Applied as 5.14 material under a new subject ("ACPI: resources: Add
> checks for ACPI IRQ override") and with some edits in the patch
> changelog.
> 
> Note, however, that this is a change in behavior that may result in
> regressions on old machines, in which case some further refinements of
> the code will be necessary.
> 
> Thanks!
> 

I just want to assure you, that also [PATCH v3] works fine on here.
Maybe I can find some time to re-activate my other, over 12 years 
old, HP notebook and check for possible issues with this patch.

I have to thank you all for your great work!

Best regards,
Manuel
