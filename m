Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699454F9E16
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Apr 2022 22:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbiDHURA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Apr 2022 16:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbiDHUQ6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Apr 2022 16:16:58 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9160335916E;
        Fri,  8 Apr 2022 13:14:53 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20220408201451usoutp0210d08fac83a24b319498e95606cd6d64~kBQcUAeZn3241332413usoutp02v;
        Fri,  8 Apr 2022 20:14:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20220408201451usoutp0210d08fac83a24b319498e95606cd6d64~kBQcUAeZn3241332413usoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1649448891;
        bh=pmblCFAzLeu2fvz8sJzGytysFBtok82pwSvzWCA3ooA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=fN1M4UK0jtgiuQVJrlaq+aRDduQs9/Mr+fVa0CfPxmGvs1PjMZOes9dLCIgGEzqfW
         KWsLP1u7OmPaLBreUNsQ07TUZoOwU8NWTmvHlkTfIDautXQCtRvbJz5UF+KOoXAJM7
         sfuYXLGs9kKRpLMo2YVN19lvcpdQC5eU1FVwG95Y=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220408201451uscas1p2830a6a7093bdc7a1ff34e692bd4c9860~kBQcCPmik2542825428uscas1p2M;
        Fri,  8 Apr 2022 20:14:51 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id EB.63.09749.BB790526; Fri, 
        8 Apr 2022 16:14:51 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220408201450uscas1p18a35fff470c6767a8414e90826b42c10~kBQbrzJA00744307443uscas1p19;
        Fri,  8 Apr 2022 20:14:50 +0000 (GMT)
X-AuditID: cbfec370-a83ff70000002615-e2-625097bbd9e4
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 6C.16.09665.AB790526; Fri, 
        8 Apr 2022 16:14:50 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Fri, 8 Apr 2022 13:14:49 -0700
Received: from SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36]) by
        SSI-EX3.ssi.samsung.com ([fe80::4031:294d:7626:e900%4]) with mapi id
        15.01.2242.008; Fri, 8 Apr 2022 13:14:49 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Vishal Verma <vishal.l.verma@intel.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5 1/3] PCI/ACPI: add a helper for retrieving _OSC
 Control DWORDs
Thread-Topic: [PATCH v5 1/3] PCI/ACPI: add a helper for retrieving _OSC
        Control DWORDs
Thread-Index: AQHYSV9XklAHfPXKM0ShtdTiGqfFL6zm7S8A
Date:   Fri, 8 Apr 2022 20:14:49 +0000
Message-ID: <20220408201443.GA17996@bgt-140510-bm01>
In-Reply-To: <20220406023746.2807328-2-vishal.l.verma@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <212CC80E922CA245BB2C594A6AE0403D@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIKsWRmVeSWpSXmKPExsWy7djXc7q7pwckGczdx2GxpCnDYvrUC4wW
        q2+uYbRYtfAam8Xyff2MFudnnWKxeLziLbvF3C9TmS1WfprCYnFrwjEmBy6PBZtKPVqOvGX1
        WLznJZPHplWdbB5TZ9d7fN4kF8AWxWWTkpqTWZZapG+XwJWx6u5+1oKbEhWr1z1kb2A8K9LF
        yMkhIWAi0fniA1sXIxeHkMBKRonv+7axQjitTBLTz21ggalafuIEI0RiLaPEjb53UM4HRonH
        u29BtexnlNh64yRYC5uAgcTv4xuZQWwRAW2JCcs+gBUxCyxnlvhwbA0bSEJYIFxiXvdfFoii
        CInNG7qgGowkvsyeyAhiswioSNz6Mh/M5gW6o/fqKbBeTgEHiRt7HoLFGQXEJL6fWsMEYjML
        iEvcejKfCeJuQYlFs/cwQ9hiEv92PWSDsBUl7n9/yQ5RryOxYPcnNgjbTuLzq/3MELa2xLKF
        r5kh9gpKnJz5BBoWkhIHV9xgAXlGQuALh8TXH++gEi4Sc1oWMULY0hLT11yGKmpnlPgwYR8r
        hDOBUeLO259QZ1hL/Ou8xj6BUWUWkstnIblqFpKrZiG5ahaSqxYwsq5iFC8tLs5NTy02zkst
        1ytOzC0uzUvXS87P3cQITGWn/x0u2MF469ZHvUOMTByMhxglOJiVRHgtkgKShHhTEiurUovy
        44tKc1KLDzFKc7AoifMuy9yQKCSQnliSmp2aWpBaBJNl4uCUamAqZGPbV5OYpWVrHLv989QJ
        M1M6rTJnTpBLzUm1Nvxt9pxx9dwzyvxrH7p7K9UnfCvT+vuJmY2DOc5ZTjtamEdC9U++y0S1
        oBmMikxPXr3gUE6zkhBuK378u/xUrqbJ5var37M+2mb7XuirSJyndXrNdA+VuY2ni37o6Lje
        njKrQfuPyVrV9tRjPDkK+w9dSWzMCHmQzZp/buNNbTX75ydF9+S1z+xfkrSxlCdpCfOdDTJR
        VhXxc/ft0drlbxcV9DSEk9fmZnJJXOkPjT9FDqaLQgLf3Gqo/Gl0/cH7KekSBxa3/mfbGcre
        OkWQ1//S4jtfhdvao5488Nml4fD/xI5pFxIv33l4L1LM9yt/oxJLcUaioRZzUXEiAHGu6MbU
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHfXbv7q5T4TYtnywCR1a+TU2jS4hKFOyLZJCplenUi2/zpV2X
        JkpaYmREGynDa8Ol0+k0qSEizpxvTFuFia10WJGaoCX5SpG6Ui/Bvv0O539+5zzw4IhgGvXC
        M3MLKFmuRCrE+GhmGUcZ2KOKSQke+HuM1N7JIFU17wDZNtUOSP3TDxip63sEyDHGgpKzLUs8
        Ur1eg5Ctq9UoaVOYOVF8scYgF1cML3HFjb0LHLFBfx8T19TdFq8ZjsRgV/jhaZQ08yYlC4pI
        5mfoP5m4+VOwqK3jK68MvPWoAs44JMKgbnQUVAE+LiDaABxRdyFssQzgRLmOxxYmAOcVw2B3
        BCOC4ebIC2SXPQh/qGhe5u6GEEKHwGVzO1YFcNydiIPDtSI2Ew+7G5o4LJ+E63XKPQ9KHIW2
        9fo9dts546HVgrHLXgE4rJnCdhvORBSc7P26FwLEAfjL0r4nQghPaJur57BvIKC2dwxheT9c
        mLVzWfaGX34t8Nh8ANQYVzGWI+Daoglh2R82P/2OsEfsg69q51B29iAcaJlEFQAyDusYBxXj
        oGIcVIyDSgO4euApp+mc9CI6NJcqFNGSHFqemy5KzcsxgJ0P8No+dK0bfLatiAYBBweDAOKI
        0MONTIlJEbilSW4VU7K8JJlcStGD4BCOCj3dxInKJAGRLimgsikqn5L973JwZ68yzpv60q5v
        0REqn8HzL/1ca96PF9YyTsH4YvbmfbNeqr4rLl055hVqnNVY4nzV0tORAxPKZ8bpi3PhZldk
        +YeOq21ImJ/Nu245631o/pYpdfyGYcvpuNVl6Jzx6gU6osTnlL95qVx2uLtS/jwgPyiEsT7O
        M8VaqlwDDidnzQ+1e5dszBT3E9bMz+59q05hbbEneJ2PmLgk1Yy1e660wOas2j/GVM8Quu2f
        tLo+sDghtDE2azwyujMxXdm3qf74+9wD35Q67ZGjSoVoq/Ge/g/XntDUUlGtFRjLnRpQun/b
        Jf5ySUuh/UypPbW1uVL1YGO7p8P2ZExtvHRHuNgRLUTpDEmIHyKjJf8Aq2jF2G8DAAA=
X-CMS-MailID: 20220408201450uscas1p18a35fff470c6767a8414e90826b42c10
CMS-TYPE: 301P
X-CMS-RootMailID: 20220406023802uscas1p1ae997b287485cd61111ecb05356f8322
References: <20220406023746.2807328-1-vishal.l.verma@intel.com>
        <CGME20220406023802uscas1p1ae997b287485cd61111ecb05356f8322@uscas1p1.samsung.com>
        <20220406023746.2807328-2-vishal.l.verma@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Apr 05, 2022 at 08:37:44PM -0600, Vishal Verma wrote:
> During _OSC negotiation, when the 'Control' DWORD is needed from the
> result buffer after running _OSC, a couple of places performed manual
> pointer arithmetic to offset into the right spot in the raw buffer.
> Add a acpi_osc_ctx_get_pci_control() helper to use the #define'd
> DWORD offsets to fetch the DWORDs needed from @acpi_osc_context, and
> replace the above instances of the open-coded arithmetic.
>=20
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Suggested-by: Davidlohr Bueso <dave@stgolabs.net>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  include/linux/acpi.h    | 13 +++++++++++++
>  drivers/acpi/bus.c      |  2 +-
>  drivers/acpi/pci_root.c |  2 +-
>  3 files changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 6274758648e3..ff4d1fdd9009 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -607,6 +607,13 @@ extern u32 osc_sb_native_usb4_control;
>  #define OSC_PCI_EXPRESS_LTR_CONTROL		0x00000020
>  #define OSC_PCI_EXPRESS_DPC_CONTROL		0x00000080
> =20
> +static inline u32 acpi_osc_ctx_get_pci_control(struct acpi_osc_context *=
context)
> +{
> +	u32 *ret =3D context->ret.pointer;
> +
> +	return ret[OSC_CONTROL_DWORD];
> +}
> +
>  #define ACPI_GSB_ACCESS_ATTRIB_QUICK		0x00000002
>  #define ACPI_GSB_ACCESS_ATTRIB_SEND_RCV         0x00000004
>  #define ACPI_GSB_ACCESS_ATTRIB_BYTE		0x00000006
> @@ -1003,6 +1010,12 @@ static inline int acpi_register_wakeup_handler(int=
 wake_irq,
>  static inline void acpi_unregister_wakeup_handler(
>  	bool (*wakeup)(void *context), void *context) { }
> =20
> +struct acpi_osc_context;
> +static inline u32 acpi_osc_ctx_get_pci_control(struct acpi_osc_context *=
context)
> +{
> +	return 0;
> +}
> +
>  #endif	/* !CONFIG_ACPI */
> =20
>  #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 07f604832fd6..4992e05cf429 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -405,7 +405,7 @@ static void acpi_bus_osc_negotiate_usb_control(void)
>  	}
> =20
>  	osc_sb_native_usb4_control =3D
> -		control & ((u32 *)context.ret.pointer)[OSC_CONTROL_DWORD];
> +		control &  acpi_osc_ctx_get_pci_control(&context);
> =20
>  	acpi_bus_decode_usb_osc("USB4 _OSC: OS supports", control);
>  	acpi_bus_decode_usb_osc("USB4 _OSC: OS controls",
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index b76db99cced3..40a74ff3fa02 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -185,7 +185,7 @@ static acpi_status acpi_pci_run_osc(acpi_handle handl=
e,
> =20
>  	status =3D acpi_run_osc(handle, &context);
>  	if (ACPI_SUCCESS(status)) {
> -		*retval =3D *((u32 *)(context.ret.pointer + 8));
> +		*retval =3D acpi_osc_ctx_get_pci_control(&context);
>  		kfree(context.ret.pointer);
>  	}
>  	return status;
> --=20
> 2.35.1
>=20

Looks good.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>=
