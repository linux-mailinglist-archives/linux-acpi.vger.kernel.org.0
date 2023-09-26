Return-Path: <linux-acpi+bounces-154-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227F07AF2FB
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 20:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C7DFE281175
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 18:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF21D47C72
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 18:31:38 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3A128E08
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 17:59:02 +0000 (UTC)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0D9124
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 10:59:00 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-57b68555467so688524eaf.0
        for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 10:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695751139; x=1696355939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3HFtm8z4059pxePSB8QN+73BTKFru7e3SZAZ1q07Qxo=;
        b=J/W37nktElnO95gqZw6kaYhDQ1dC7eX2xKDT9s1mU5e0VBpXvnXovWzHNZ2jBcIgdl
         9+ylmGcHPnnVIchhjik91K9H3gxN1UZff2BN2loslTei9kwJ4QA0vANbsxgC76085jx8
         Hh1WhE+JPVmGr+9N9gIUXF9JqSilsMLGsQW3OSRw5Mm5GpiW39Nksh391NLdj0fXiWz4
         4yImVMfo0iFH2kCHX5fUAQ4PRvlPfeetb4xUDS+HdJ0NEgGY7TvBJTc/mrOPibqRKeXi
         0QhM112rr9mwCUTiEVZDMy7xEwxa1MnPLVmBSDwDmFVN2UbAF9SNhzy3t6w/N8zFk0YE
         UsTg==
X-Gm-Message-State: AOJu0YwTRn65HscMgCvhF4FDx16xqZp8CqGW1AJhkTMb2h4FMjobA3UJ
	5KRW1V8uWGflq1Wjjvkals1AtZK/cXqe3E7T7PI=
X-Google-Smtp-Source: AGHT+IE+YIYKT8U9RvujoQXdR9ORKQ+rXLDruC8JfH6JhLpL2FD/b3yAJVXZBaC0oCaAsW6scp/OOgHVc1Tr1DN5oZY=
X-Received: by 2002:a4a:bb82:0:b0:57b:3b64:7ea5 with SMTP id
 h2-20020a4abb82000000b0057b3b647ea5mr9437697oop.1.1695751139616; Tue, 26 Sep
 2023 10:58:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13356251.uLZWGnKmhe@kreacher>
In-Reply-To: <13356251.uLZWGnKmhe@kreacher>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 Sep 2023 19:58:48 +0200
Message-ID: <CAJZ5v0iNV52NMTe6CWpyDdFMNB31gTkry9W9Sz2szx=24-Kmyg@mail.gmail.com>
Subject: Re: [RFC] ACPI Code First ECR: Support for resetting the
 Multiprocessor Wakeup Mailbox
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, acpica-devel@lists.linuxfoundation.org, 
	"Kirill A . Shutemov" <kirill.shtuemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 21, 2023 at 9:51=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The Multiprocessor Wakeup Structure in MADT is used for starting applicat=
ion
> processors (APs) on systems without a hardware mechanism suitable for thi=
s
> purpose.  It describes a mailbox (Multiprocessor Wakeup Mailbox) allowing
> the boot CPU to send commands to APs and, in particular, to cause them to
> jump to a wakeup vector provided by the OS.
>
> As currently defined, after using the Multiprocessor Wakeup Mailbox to ma=
ke
> a given AP jump to the wakeup vector, it cannot be used any more with tha=
t AP,
> which is problematic in some use cases, like kexec() or hibernation, beca=
use
> it makes transferring control of APs from one OS instance to another diff=
icult.
>
> For this reason, the definition of Multiprocessor Wakeup Structure is cha=
nged
> so as to allow the Multiprocessor Wakeup Mailbox to be reset in order to =
be
> used once again with a given AP.
>
> # Title: Add support for resetting the Multiprocessor Wakeup Mailbox
>
> # Status: Draft
>
> # Document: ACPI Specification 6.6
>
> # License
> SPDX-License Identifier: CC-BY-4.0
>
> # Submitter:
> * Sponsor: Rafael J. Wysocki, Intel
> * Creator/Contributor: Kirill Shutemov, Intel
>
> # Summary of the Change
> Add a ResetVector field to Multiprocessor Wakeup Structure in order to pr=
ovide
> the OS with a physical address of a Multiprocessor Wakeup Mailbox entry p=
oint
> for application processors that need to use the mailbox again after havin=
g used
> it once already.
>
> # Benefits of the Change
> It will allow a new OS instance to be started without going through a ful=
l
> system reset, for example after carrying out an OS update.
>
> There are valid use cases in which the new OS started this way is differe=
nt from
> the OS that has been running so far and in the absence of a hardware mech=
anism
> for resetting application processors, the only way to pass control of the=
m from
> one OS instance to the other is through the platform firmware.
>
> # Impact of the Change
> OS and platform firmware will need to recognize version 1 of the Multipro=
cessor
> Wakeup Mailbox.
>
> # Detailed Description of the Change
> ACPI specification source changes needed to implement this proposal are a=
s
> follows:
>
> ---
>  source/05_ACPI_Software_Programming_Model.rst |   40 +++++++++++++++++++=
++++---
>  1 file changed, 36 insertions(+), 4 deletions(-)
>
> Index: ACPI_spec/source/05_ACPI_Software_Programming_Model.rst
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ACPI_spec.orig/source/05_ACPI_Software_Programming_Model.rst
> +++ ACPI_spec/source/05_ACPI_Software_Programming_Model.rst
> @@ -4488,7 +4488,27 @@ The OS section can only be written by OS
>
>  The OS section contains command, flags, APIC ID, and a wakeup address. A=
fter the OS detects the processor number from the MADT table, the OS may pr=
epare the wakeup routine, fill the wakeup address field in the mailbox, ind=
icate which processor need to be wakeup in the APID ID field, and send wake=
up command. Once an application processor detects the wakeup command and it=
s own APIC ID, the application processor will jump to the OS-provided wakeu=
p address. The application processor will ignore the command if the APIC ID=
 does not match its own.
>
> -For each application processor, the mailbox can be used only once for th=
e wakeup command. After the application process takes the action according =
to the command, this mailbox will no longer be checked by this application =
processor. Other processors can continue using the mailbox for the next com=
mand.
> +For each application processor, the mailbox can be used only once for th=
e wakeup command, unless
> +the MailBoxVersion field value is greater than 0 and the ResetVector fie=
ld contains a nonzero value.
> +
> +After the application process takes the action according to the command,=
 this mailbox will no longer
> +be checked by this application processor until the mailbox is reset for =
it as described below. Other
> +processors can continue using the mailbox for the next command.
> +
> +In case the mailbox needs to be used once again, for example in order to=
 start a new version of
> +the OS without carrying out a full system reset, the ResetVector field v=
alue can be used for
> +making the given application processor enter a state to check the mailbo=
x. For this purpose,
> +the OS needs to set up the mailbox reset environment, as per the ResetVe=
ctor field description,
> +for the application processor in question and make that application proc=
essor jump to the
> +firmware-provided mailbox reset address retrieved from the ResetVector f=
ield. This needs to be
> +done for each application processor individually and doing it for one ap=
plication processor does
> +not affect the other application processors, so they can continue to ope=
rate undisturbed.  However,
> +if the ResetVector field value is 0, the mailbox cannot be reset and so =
it can be used only once.
> +
> +After an application processor has jumped to the reset address, the OS i=
s required to verify that
> +the mailbox responds to commands by sending the test command to it. When=
 it responds by changing
> +the command to noop, the OS is not required to maintain the mailbox rese=
t environment for the given
> +application processor any more.
>
>  .. list-table:: **Multiprocessor Wakeup Structure**
>     :name: multiprocessor-wakeup-structure-table
> @@ -4507,11 +4527,11 @@ For each application processor, the mail
>     * - Length
>       - 1
>       - 1
> -     - 16
> +     - 24
>     * - MailBoxVersion
>       - 2
>       - 2
> -     - Version of the mailbox. 0 for this version of the spec.
> +     - Version of the mailbox. 1 for this version of the spec.
>     * - *Reserved*
>       - 4
>       - 4
> @@ -4520,6 +4540,17 @@ For each application processor, the mail
>       - 8
>       - 8
>       - Physical address of the mailbox. It must be in ACPINvs. It must a=
lso be 4K bytes aligned. See :numref:`multiprocessor-wakeup-mailbox-structu=
re` for the Mailbox definition.
> +   * - ResetVector
> +     - 8
> +     - 16
> +     - | The mailbox reset vector address for application processor(s).
> +       | For Intel processors, the mailbox reset environment is:
> +       |   Interrupts must be disabled.
> +       |   RFLAGES.IF set to 0.
> +       |   Long mode enabled.
> +       |   Paging mode is enabled and physical memory for reset vector i=
s identity mapped (virtual address equals physical address).
> +       |   Reset vector must be contained within one physical page.
> +       |   Selectors are set to flat and otherwise not used.
>
>  .. list-table:: **Multiprocessor Wakeup Mailbox Structure**
>     :name: multiprocessor-wakeup-mailbox-structure
> @@ -4536,7 +4567,8 @@ For each application processor, the mail
>       - 0
>       - | 0: Noop - no operation.
>         | 1: Wakeup =E2=80=93 jump to the wakeup vector.
> -       | 2-0xFFFF: Reserved
> +       | 2: Test - respond by changing the command to Noop.
> +       | 3-0xFFFF: Reserved.
>     * - *Reserved*
>       - 2
>       - 2
>
>

This ECR has been approved as submitted.

