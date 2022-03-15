Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12AB4DA3BE
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Mar 2022 21:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348213AbiCOUKt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Mar 2022 16:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiCOUKt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Mar 2022 16:10:49 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF0350E1D
        for <linux-acpi@vger.kernel.org>; Tue, 15 Mar 2022 13:09:36 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id f38so691663ybi.3
        for <linux-acpi@vger.kernel.org>; Tue, 15 Mar 2022 13:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oAdjAAq/KG/wEX5lpCpqvlipZDGaYrLNp1m2PzM0U/4=;
        b=nkGcA7ns8/0PRNZ8ssrtIMmnDuHcpyHFTGD897tsBrQkPtQpVB/u48LYBqGgLVo/aq
         ct1BphWC9HrV9kmlMT288rH1cuOVxXHr6tvL+7nU0V5MEAEYfrXMaRtpo0jUkBwIzoUz
         kbGq9rRYsgwSCELfm2vP8a1sx08TF6tXCJUaWxwVwn9XeM9Bfi+KWaYJ/1HAfAW7oMxm
         nWgYAM9xtqsOplpH155lsa9G2EvT3frAyDMcYC1203TLi4CwvBROkCFeqAJ1X/EduxuS
         98WSByPEqfmjt7CwDbKlwAv9RaXu+MJvqnr0f6lLDoYyzDVY488iesZgePthhkWlcLZd
         Vw0w==
X-Gm-Message-State: AOAM532/EkZGzx2yx4mKdPE6YLiZ82zrhXMCKkigbI+rCryvrQ4iOvSm
        tjOTkqK+7viOEMJcV2WmvJxJHsv/Q+GeqPLExQw=
X-Google-Smtp-Source: ABdhPJx5XWdXr3oEInDOAKemVmW428i35enaroYTfZUfJDvzRGB9I9a72j+nAlcb6lYrtQe/9p8T1nq3PqF5+NKGS28=
X-Received: by 2002:a25:3a41:0:b0:628:86a2:dbc with SMTP id
 h62-20020a253a41000000b0062886a20dbcmr24181199yba.633.1647374974126; Tue, 15
 Mar 2022 13:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220310212805.3786-1-mario.limonciello@amd.com>
 <CAJZ5v0ibnaZZu_Gxngjbu5vzdQaJog8XZnJP6_msLqV_gi4Zig@mail.gmail.com>
 <BL1PR12MB5157839B59321A1A6AD9F73FE20E9@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CAJZ5v0g_TH+OeQkBwXELKZiRcxjLvstr8G_bXOBChJ94sTkvHw@mail.gmail.com>
 <BL1PR12MB51576398DFBD0EADC6AFEAF1E2109@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CAJZ5v0i=ecAksq0TV+iLVObm-=fUfdqPABzzkgm9K6KxO1ZCcg@mail.gmail.com>
In-Reply-To: <CAJZ5v0i=ecAksq0TV+iLVObm-=fUfdqPABzzkgm9K6KxO1ZCcg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 15 Mar 2022 21:09:22 +0100
Message-ID: <CAJZ5v0iStA0JmO0H3z+VgQsVuQONVjKPpw0F5HKfiq=Gb6B5yw@mail.gmail.com>
Subject: Re: [PATCH v6] ACPI: bus: For platform OSC negotiate capabilities
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Hou, Xiaomeng (Matthew)" <Xiaomeng.Hou@amd.com>,
        "Liu, Aaron" <Aaron.Liu@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: multipart/mixed; boundary="000000000000254c0205da476033"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

--000000000000254c0205da476033
Content-Type: text/plain; charset="UTF-8"

On Tue, Mar 15, 2022 at 11:34 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Mar 15, 2022 at 5:30 AM Limonciello, Mario
> <Mario.Limonciello@amd.com> wrote:
> >
> > [AMD Official Use Only]
> >
> >
> >
> > > -----Original Message-----
> > > From: Rafael J. Wysocki <rafael@kernel.org>
> > > Sent: Monday, March 14, 2022 15:01
> > > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > > Cc: Rafael J. Wysocki <rafael@kernel.org>; Rafael J . Wysocki
> > > <rjw@rjwysocki.net>; ACPI Devel Maling List <linux-acpi@vger.kernel.org>;
> > > Mika Westerberg <mika.westerberg@linux.intel.com>; Hou, Xiaomeng
> > > (Matthew) <Xiaomeng.Hou@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>;
> > > Huang, Ray <Ray.Huang@amd.com>; Hans de Goede
> > > <hdegoede@redhat.com>
> > > Subject: Re: [PATCH v6] ACPI: bus: For platform OSC negotiate capabilities
> > >
> > > On Mon, Mar 14, 2022 at 12:45 AM Limonciello, Mario
> > > <Mario.Limonciello@amd.com> wrote:
> > > >
> > > > [Public]
> > > >
> > > > > I would do
> > > > >
> > > > > if (capbuf[OSC_SUPPORT_DWORD] ==
> > > capbuf_ret[OSC_SUPPORT_DWORD])
> > > > >         capbuf[OSC_QUERY_DWORD] = 0;
> > > > > else
> > > > >         capbuf[OSC_SUPPORT_DWORD] &=
> > > capbuf_ret[OSC_SUPPORT_DWORD];
> > > > >
> > > > > so that the loop terminates even if the firmware does strange things
> > > > > and then it would only be necessary to check
> > > capbuf[OSC_QUERY_DWORD]
> > > > > in the loop termination condition.
> > > > >
> > > > > Would that work?
> > > > >
> > > >
> > > > I think it will.  I'll try it and send up a v7 if so.
> > > >
> > > > > > +               kfree(context.ret.pointer);
> > > > > > +       } while (capbuf[OSC_QUERY_DWORD] &&
> > > > > capbuf[OSC_SUPPORT_DWORD]);
> > > > > >
> > > > > > -       /* Now run _OSC again with query flag clear */
> > > > > > -       capbuf[OSC_QUERY_DWORD] = 0;
> > > > > > +       /*
> > > > > > +        * Avoid problems with BIOS dynamically loading tables by
> > > indicating
> > > > > > +        * support for CPPC even if it was masked.
> > > > >
> > > > > What exactly do you mean by "BIOS dynamically loading tables"?
> > > >
> > > > As mentioned in commit 159d8c274fd9:
> > > >
> > > >     On certain systems the BIOS loads SSDT tables dynamically based on the
> > > >     capabilities the OS claims to support. However, on these systems the
> > > >     _OSC actually clears some of the bits (under certain conditions) so what
> > > >     happens is that now when we call the _OSC twice the second time we
> > > pass
> > > >     the cleared values and that results errors like below to appear on the
> > > >     system log:
> > > >
> > > >       ACPI BIOS Error (bug): Could not resolve symbol [\_PR.PR00._CPC],
> > > AE_NOT_FOUND (20210105/psargs-330)
> > > >       ACPI Error: Aborting method \_PR.PR01._CPC due to previous error
> > > (AE_NOT_FOUND) (20210105/psparse-529)
> > > >
> > > > This block  is to avoid regressing that again by forcing it on these systems.
> > >
> > > Well, this means that the code before and after the patch is not
> > > actually following the spec.
> > >
> > > First off, as mentioned in the changelog of commit 159d8c274fd9 (in
> > > the part that has not been quoted above), the OS is required to pass
> > > the same set of capabilities every time _OSC is evaluated.  This
> > > doesn't happen after the change.
> > >
> > > Second, acpi_bus_osc_negotiate_platform_control() should take the
> > > capabilities mask returned by the platform which it doesn't do without
> > > the patch.
> >
> > Right on both points.
> >
> > >
> > > That latter piece appears to be the bug in question here and IMO
> > > fixing it doesn't even require calling acpi_run_osc() with the query
> > > flag set for multiple times.
> >
> > I think just taking the results will re-introduce the CPC bug though
> > won't it?  So how to avoid it but also to take the results?
>
> I think that the OS should not ask for the control of the CPPC bits if
> they are masked by the firmware and it should avoid invoking _CPC
> then.
>
> Otherwise we risk breaking legitimate cases in which the firmware
> actually doesn't want the OS to control those bits.

I'm basically talking about reverting commit 159d8c274fd9, as the part
of the _OSC definition in the spec it is based on appears to be bogus
(that will be addressed separately via the ACPI spec process), and
applying the attached change on top of that.

If this looks good to you, I'll take care of it.

--000000000000254c0205da476033
Content-Type: text/x-patch; charset="US-ASCII"; name="acpi-osc-fix-cppc-fallout.patch"
Content-Disposition: attachment; filename="acpi-osc-fix-cppc-fallout.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l0skgt640>
X-Attachment-Id: f_l0skgt640

LS0tCiBkcml2ZXJzL2FjcGkvYnVzLmMgICAgICAgfCAgICA0ICsrKysKIGRyaXZlcnMvYWNwaS9j
cHBjX2FjcGkuYyB8ICAgIDMgKysrCiBpbmNsdWRlL2xpbnV4L2FjcGkuaCAgICAgfCAgICAxICsK
IDMgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspCgpJbmRleDogbGludXgtcG0vZHJpdmVy
cy9hY3BpL2J1cy5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LXBtLm9yaWcvZHJpdmVycy9hY3BpL2J1
cy5jCisrKyBsaW51eC1wbS9kcml2ZXJzL2FjcGkvYnVzLmMKQEAgLTI3OCw2ICsyNzgsOCBAQCBi
b29sIG9zY19zYl9hcGVpX3N1cHBvcnRfYWNrZWQ7CiBib29sIG9zY19wY19scGlfc3VwcG9ydF9j
b25maXJtZWQ7CiBFWFBPUlRfU1lNQk9MX0dQTChvc2NfcGNfbHBpX3N1cHBvcnRfY29uZmlybWVk
KTsKIAorYm9vbCBvc2Nfc2JfY3BwY19jb250cm9sX2dyYW50ZWQ7CisKIC8qCiAgKiBBQ1BJIDYu
NCBPcGVyYXRpbmcgU3lzdGVtIENhcGFiaWxpdGllcyBmb3IgVVNCLgogICovCkBAIC0zNDYsNiAr
MzQ4LDggQEAgc3RhdGljIHZvaWQgYWNwaV9idXNfb3NjX25lZ290aWF0ZV9wbGF0ZgogCQljYXBi
dWZfcmV0W09TQ19TVVBQT1JUX0RXT1JEXSAmIE9TQ19TQl9BUEVJX1NVUFBPUlQ7CiAJb3NjX3Bj
X2xwaV9zdXBwb3J0X2NvbmZpcm1lZCA9CiAJCWNhcGJ1Zl9yZXRbT1NDX1NVUFBPUlRfRFdPUkRd
ICYgT1NDX1NCX1BDTFBJX1NVUFBPUlQ7CisJb3NjX3NiX2NwcGNfY29udHJvbF9ncmFudGVkID0g
Y2FwYnVmX3JldFtPU0NfU1VQUE9SVF9EV09SRF0gJgorCQkoT1NDX1NCX0NQQ19TVVBQT1JUIHwg
T1NDX1NCX0NQQ1YyX1NVUFBPUlQpOwogCW9zY19zYl9uYXRpdmVfdXNiNF9zdXBwb3J0X2NvbmZp
cm1lZCA9CiAJCWNhcGJ1Zl9yZXRbT1NDX1NVUFBPUlRfRFdPUkRdICYgT1NDX1NCX05BVElWRV9V
U0I0X1NVUFBPUlQ7CiAKSW5kZXg6IGxpbnV4LXBtL2RyaXZlcnMvYWNwaS9jcHBjX2FjcGkuYwo9
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09Ci0tLSBsaW51eC1wbS5vcmlnL2RyaXZlcnMvYWNwaS9jcHBjX2FjcGkuYworKysg
bGludXgtcG0vZHJpdmVycy9hY3BpL2NwcGNfYWNwaS5jCkBAIC02NTYsNiArNjU2LDkgQEAgaW50
IGFjcGlfY3BwY19wcm9jZXNzb3JfcHJvYmUoc3RydWN0IGFjcAogCWFjcGlfc3RhdHVzIHN0YXR1
czsKIAlpbnQgcmV0ID0gLUVGQVVMVDsKIAorCWlmICghb3NjX3NiX2NwcGNfY29udHJvbF9ncmFu
dGVkKQorCQlyZXR1cm4gLUVOT0RFVjsKKwogCS8qIFBhcnNlIHRoZSBBQ1BJIF9DUEMgdGFibGUg
Zm9yIHRoaXMgQ1BVLiAqLwogCXN0YXR1cyA9IGFjcGlfZXZhbHVhdGVfb2JqZWN0X3R5cGVkKGhh
bmRsZSwgIl9DUEMiLCBOVUxMLCAmb3V0cHV0LAogCQkJQUNQSV9UWVBFX1BBQ0tBR0UpOwpJbmRl
eDogbGludXgtcG0vaW5jbHVkZS9saW51eC9hY3BpLmgKPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgtcG0u
b3JpZy9pbmNsdWRlL2xpbnV4L2FjcGkuaAorKysgbGludXgtcG0vaW5jbHVkZS9saW51eC9hY3Bp
LmgKQEAgLTU3OSw2ICs1NzksNyBAQCBhY3BpX3N0YXR1cyBhY3BpX3J1bl9vc2MoYWNwaV9oYW5k
bGUgaGFuCiAKIGV4dGVybiBib29sIG9zY19zYl9hcGVpX3N1cHBvcnRfYWNrZWQ7CiBleHRlcm4g
Ym9vbCBvc2NfcGNfbHBpX3N1cHBvcnRfY29uZmlybWVkOworZXh0ZXJuIGJvb2wgb3NjX3NiX2Nw
cGNfY29udHJvbF9ncmFudGVkOwogZXh0ZXJuIGJvb2wgb3NjX3NiX25hdGl2ZV91c2I0X3N1cHBv
cnRfY29uZmlybWVkOwogCiAvKiBVU0I0IENhcGFiaWxpdGllcyAqLwo=
--000000000000254c0205da476033--
