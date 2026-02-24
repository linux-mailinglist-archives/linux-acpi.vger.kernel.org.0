Return-Path: <linux-acpi+bounces-21123-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBLyHquDnWlsQQQAu9opvQ
	(envelope-from <linux-acpi+bounces-21123-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 11:55:39 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1D7185B57
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 11:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2055A309521D
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 10:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AE437B3F2;
	Tue, 24 Feb 2026 10:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6pgoeDG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBFD37AA9A
	for <linux-acpi@vger.kernel.org>; Tue, 24 Feb 2026 10:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771930477; cv=none; b=Jgc+PJrU4XXnvunoURznwozn7XFWymzqyXwqFF5waKNkYeyd1LvsO9Zt5ZO2S5rRujMziSgOwMYDMi6et4CEWLObNlX7Zogx2s6ZhQOos6bSMWUSQJ0fIoqanlh2n72pXSu9VqTMC6EXY3PcfSJ8kRfNMSA+BAAscslWZCNo+5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771930477; c=relaxed/simple;
	bh=Ar8h4pwA1NDtg967Id6YIJ0hbFJ+kyEH685q68t02QU=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hje48D6xkvNCiaVmSmOrMg/mBvLD/0SJCVHfXKFefscADm7HAcmRB1H2F3AqN+pS15RczMfHrDmdJ8N7ppOtZNpfUbO8q+C/C/MIyCyqQm4c7zobM9QtfUdNtpFPCuTR02RYlxlRGAaSrYVupIAJr7xrke1caMI8Ut2J9fjt2pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6pgoeDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7347EC2BC87
	for <linux-acpi@vger.kernel.org>; Tue, 24 Feb 2026 10:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771930477;
	bh=Ar8h4pwA1NDtg967Id6YIJ0hbFJ+kyEH685q68t02QU=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=M6pgoeDGL67rxGCyufC4jL6jDjmdisqXHbWqNCPcw6GOAHDURfGTlBlbEMGfJPoiT
	 VybiFBRSJIoDHfXqPhzQ/0+quhEKQ9qk58BiOCZ8L/4dHMv8XjxpQNOyT6sp+KwcMg
	 QJBbn2plHMVRDm7Pbiu4U7Y5NblmauZOc6xZnKZmlcp/lKkDCNOQOqSGG4NaoGrIoJ
	 iahNexx6alWPwSLgdrsL0m/jVM3hbim8HvEnKVAE2pWTYJAOCzzInR545iXunE5ofm
	 OmtWVGhSeIzxg2vyv+VqQoZCeYhs1meV02dKq8b4pja1URbLNhaMBGxWGpinv1/ei/
	 JOQlA32OyuS8w==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38706f96202so33484261fa.3
        for <linux-acpi@vger.kernel.org>; Tue, 24 Feb 2026 02:54:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWlZ7qFJj+x1b0KTlR32yQwsjLTw+cz4qcIzg0b++tUsjHMEySZ/PHE+BJO2Lcwjiauh2pLf64Y1CmN@vger.kernel.org
X-Gm-Message-State: AOJu0YzmivD9TdpsoSjQNgxkgOSjiD6DCWe4jZpJDBYPs4XUsEA/8g2r
	Wp2A+YzH7k/+cL3ngO2OEzFqL7nO/BpwxB0OJoTFFVMOxUrfZdQjIBaByEU3KVtGXci290rMXNl
	Eg8akc7zHSe7jV/hJSY5NYGWybQM0kLu44TqXJA/3uw==
X-Received: by 2002:a05:651c:1602:b0:385:beca:f6d2 with SMTP id
 38308e7fff4ca-389a5c92b9bmr38250061fa.1.1771930475771; Tue, 24 Feb 2026
 02:54:35 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Feb 2026 04:54:34 -0600
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Feb 2026 04:54:34 -0600
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <aZ19kFCv_3QUkvPL@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224-pci-m2-e-v5-0-dd9b9501d33c@oss.qualcomm.com>
 <20260224-pci-m2-e-v5-2-dd9b9501d33c@oss.qualcomm.com> <CAMRc=MethnZu_GrujadpBZwj4SpgdNXEnTfEikSvPkO2f9MJjg@mail.gmail.com>
 <aZ19kFCv_3QUkvPL@smile.fi.intel.com>
Date: Tue, 24 Feb 2026 04:54:34 -0600
X-Gmail-Original-Message-ID: <CAMRc=Md5K=qPbbjSX6eX7EUwgPHpPkUhOPF7RsqD5gejXK2rnQ@mail.gmail.com>
X-Gm-Features: AaiRm50PZNtQU10kvSbt1uPfme98Sm6BHfpF2pr5K4ZzyNi38Xb-W4BKtnbBLf4
Message-ID: <CAMRc=Md5K=qPbbjSX6eX7EUwgPHpPkUhOPF7RsqD5gejXK2rnQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] serdev: Add an API to find the serdev controller
 associated with the devicetree node
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-acpi@vger.kernel.org, 
	Hans de Goede <johannes.goede@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21123-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,vger.kernel.org,linaro.org,linuxfoundation.org,linux.dev,linux.intel.com,squebb.ca,gmail.com,holtmann.org,bgdev.pl];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,qualcomm.com:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi,manivannan.sadhasivam.oss.qualcomm.com,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: ED1D7185B57
X-Rspamd-Action: no action

On Tue, 24 Feb 2026 11:29:36 +0100, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> said:
> On Tue, Feb 24, 2026 at 02:16:17AM -0800, Bartosz Golaszewski wrote:
>> On Tue, 24 Feb 2026 06:30:48 +0100, Manivannan Sadhasivam via B4 Relay
>> <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
>> >
>> > Add of_find_serdev_controller_by_node() API to find the serdev controller
>> > device associated with the devicetree node.
>
> ...
>
>> > +struct serdev_controller *of_find_serdev_controller_by_node(struct device_node *node)
>> > +{
>> > +	struct device *dev = bus_find_device_by_of_node(&serdev_bus_type, node);
>> > +
>> > +	return (dev && dev->type == &serdev_ctrl_type) ? to_serdev_controller(dev) : NULL;
>> > +}
>> > +EXPORT_SYMBOL_GPL(of_find_serdev_controller_by_node);
>>
>> I'm not sure if I commented on it before but there's no reason for this to be
>> OF-centric. It would work equally well as (I think the same should keep the
>> "serdev" prefix too for correct namespacing):
>>
>> struct serdev_controller *serdev_find_controller_by_fwnode(struct
>> fwnode_handle *fwnode)
>> {
>> 	struct device *dev = bus_find_device_by_fwnode();
>>
>> 	...
>> }
>>
>> It would be more flexible and users can always use to_of_node().
>
> IIRC it was discussed already and the fact of use only in DT overlays and
> absence of the user for all this time makes it feel like solving non-existing
> problem. So OF-centric in this case seems to be fine.
>

Ok then.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

