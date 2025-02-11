Return-Path: <linux-acpi+bounces-11028-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC5DA31344
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 18:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 132FA1886135
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 17:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72CD26215A;
	Tue, 11 Feb 2025 17:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="Bx4ECKGQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="klWqRZJO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2BF261571;
	Tue, 11 Feb 2025 17:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739295710; cv=none; b=RZ8LhBD+zi4cxLDibSfdQGOzT2A+3JxxMxNxuqH9smwYi90La6mLcF9QHokxLQVa1eWXQSEi+NnvwgGLZzmiK0gmRgjQg1gOMrqWgEB11DXXXCBa3g7tAFnwxQ//5ZxaAmtYKOwHQhHBQhanD3s6/uDWzFeTNi0CS8bTu8i9P4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739295710; c=relaxed/simple;
	bh=5aQ92cdC4eJfVEoFmrdzyqjx6f3bfVgQOkqs4X/GeOg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=u+obR53rPwHjZTovb8MXs8kaCA2TKoxKj/+Qh4lQCyRPOm7wN3p+Y7xYf21h46MS6dN/Qe+jTvJN0BIEC+M7+rkbGPO2BXr8GZUN7YdvdIlXbuiPlN4QmprH/ZOK+qNSWdVq6/a+nk/8Ce0/gqzdW6Uh0BqFvf0wOFR4vHOikvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=Bx4ECKGQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=klWqRZJO; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 581C011400EA;
	Tue, 11 Feb 2025 12:41:46 -0500 (EST)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-02.internal (MEProxy); Tue, 11 Feb 2025 12:41:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1739295706;
	 x=1739382106; bh=nv/+K3v73BFIxVV/VmtwVsySnWMnTNl2C8GVI0us/tw=; b=
	Bx4ECKGQT4jbM9xgSSk0gAiEG03RWAgQXPy4GmuzYP1pGgEQjPNunsCRA3v3SFiy
	D1o/idHOIw2YZteeSKtr0P5/3zvEMCzp1v1k3d6rAfd4LX/+YLGrlnFP3STQGJWx
	BRPchl8nxX01c2wsbXCrcbhPXYCcCbYeLjeZ2kKr3Yn0hVmxUQbUFyCjsdLq2h1Y
	2QzbDps83v2LqY7TZqOChrZZJIjWx8Uvq4o7SWNz9OiyFqUqc5lObNHIwlQnVGEF
	73oVc4+h+UHLC++JLvv78m58PQ5NMlVEvumqzadewXNy01EmwkNpWL/ieAmkkMGz
	sHfeQbBgo3D+74bWgHDz7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739295706; x=
	1739382106; bh=nv/+K3v73BFIxVV/VmtwVsySnWMnTNl2C8GVI0us/tw=; b=k
	lWqRZJOaFsPCFes+fjuriXVuqKdOhVzGr5rnQ+XgGshqmrGToiYbdG/0eAh+4nT2
	odSp4WaHqjHtcHPiC8ODRPyp4RgcjX3XNGOPrYXY7p07i1kC8DOAHX22FiDrRroX
	u7wdHN03Ys40PxhBQT8XLdBpP24ENrCKzT2r1+hCj0BYcCqgSUL8xFgzn2NCyIIu
	3qpa5wb+HFRvZ3JvFIpBorQv0UxBB/vACG7nmIz8Ic/j/erRowDqzHujk0wCmE3k
	5F+KQIDh0YCLNZyNwrfWal39RMOpMOKQzPY5WLtp4lpr5phQThKr3NPk2ZgWYQCW
	ngKZE7z/bgc1TiMVgI45Q==
X-ME-Sender: <xms:2YurZ2SBjG-oDIbfC1NklnnDkCDYultpWZarcKdilxytBKI4oT54MQ>
    <xme:2YurZ7wLOQP0tBokBBfBuJpja5m1rLcUibJZ9bykEImnPHEiW8gCtP8UPE2GiCWNy
    eOu0T8AF6QSfYmiIuM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegudeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdforghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvg
    hnohhvohesshhquhgvsggsrdgtrgeqnecuggftrfgrthhtvghrnhepleevvdeihfffgeel
    ieeugedtiefggeelledtheektdduudeggeefheeuleduvdehnecuffhomhgrihhnpehgih
    hthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquh
    gvsggsrdgtrgdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehmrghrihhordhlihhmohhntghivghllhhosegrmhgurdgtohhmpdhrtghpth
    htohepshgrmhhithholhhvrghnvghnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehl
    khhmlhesjhhohhhnrhhofihlvgihrdhmvgdprhgtphhtthhopehkvggvsheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhgvnhgssehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehnrghthhgrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehllhhvmheslhhishhtshdrlhhinhhugidruggv
    vhdprhgtphhtthhopehprghttghhvghssehlihhsthhsrdhlihhnuhigrdguvghv
X-ME-Proxy: <xmx:2YurZz0_hXD_ut2rIRPTag6aCQEgpM322OuflG9o4gvypQdfsSUolA>
    <xmx:2YurZyAnrBYlhNEmY-kXK_SO-OjgFC4-3UkfLWqYUfLlaGIYhU_8hw>
    <xmx:2YurZ_gsN2CjfcV29-sAIwAcr5pFb1zSre-PtG13YhS6PVdy-sMDtA>
    <xmx:2YurZ-qRa49YoFR7S09TteGigx9HjHYhpGCen0LpM7ZZeBKjpiDczg>
    <xmx:2ourZ4bInq3Wxcg_sVANOlqFbeNIVJBQ-JsI0m4MsEWmB0VJYetfxVPr>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9B53C3C0066; Tue, 11 Feb 2025 12:41:45 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 11 Feb 2025 12:41:25 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Nathan Chancellor" <nathan@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>
Cc: "Hans de Goede" <hdegoede@redhat.com>,
 "Limonciello, Mario" <mario.limonciello@amd.com>,
 "Kees Cook" <kees@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev,
 stable@vger.kernel.org, "John Rowley" <lkml@johnrowley.me>
Message-Id: <f9bae655-2835-4623-b18e-1d370dd220d5@app.fastmail.com>
In-Reply-To: <52c49252-7a81-4d27-a8a9-b2f1e5f837df@app.fastmail.com>
References: 
 <20250210-acpi-platform_profile-fix-cfi-violation-v3-1-ed9e9901c33a@kernel.org>
 <52c49252-7a81-4d27-a8a9-b2f1e5f837df@app.fastmail.com>
Subject: Re: [PATCH v3] ACPI: platform-profile: Fix CFI violation when accessing sysfs
 files
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Feb 11, 2025, at 10:05 AM, Mark Pearson wrote:
> Hi Nathan
>
> On Mon, Feb 10, 2025, at 9:28 PM, Nathan Chancellor wrote:
>> When an attribute group is created with sysfs_create_group(), the
>> ->sysfs_ops() callback is set to kobj_sysfs_ops, which sets the ->show()
>> and ->store() callbacks to kobj_attr_show() and kobj_attr_store()
>> respectively. These functions use container_of() to get the respective
>> callback from the passed attribute, meaning that these callbacks need to
>> be the same type as the callbacks in 'struct kobj_attribute'.
>>
>> However, the platform_profile sysfs functions have the type of the
>> ->show() and ->store() callbacks in 'struct device_attribute', which
>> results a CFI violation when accessing platform_profile or
>> platform_profile_choices under /sys/firmware/acpi because the types do
>> not match:
>>
>>   CFI failure at kobj_attr_show+0x19/0x30 (target: 
>> platform_profile_choices_show+0x0/0x140; expected type: 0x7a69590c)
>>
>> There is no functional issue from the type mismatch because the layout
>> of 'struct kobj_attribute' and 'struct device_attribute' are the same,
>> so the container_of() cast does not break anything aside from CFI.
>>
>> Change the type of platform_profile_choices_show() and
>> platform_profile_{show,store}() to match the callbacks in
>> 'struct kobj_attribute' and update the attribute variables to match,
>> which resolves the CFI violation.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: a2ff95e018f1 ("ACPI: platform: Add platform profile support")
>> Reported-by: John Rowley <lkml@johnrowley.me>
>> Closes: https://github.com/ClangBuiltLinux/linux/issues/2047
>> Tested-by: John Rowley <lkml@johnrowley.me>
>> Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
>> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>> ---
>> Changes in v3:
>> - Rebase on 6.14-rc1, which includes updates to the driver to address
>>   Greg's previous concerns but this change is still needed for the
>>   legacy sysfs interface. v2 can be used for the stable backport.
>> - Link to v2: 
>> https://lore.kernel.org/r/20241118-acpi-platform_profile-fix-cfi-violation-v2-1-62ff952804de@kernel.org
>>
>> Changes in v2:
>> - Rebase on linux-pm/acpi
>> - Pick up Sami's reviewed-by tag
>> - Adjust wording around why there is no functional issue from the
>>   mismatched types
>> - Link to v1: 
>> https://lore.kernel.org/r/20240819-acpi-platform_profile-fix-cfi-violation-v1-1-479365d848f6@kernel.org
>> ---
>>  drivers/acpi/platform_profile.c | 26 +++++++++++++-------------
>>  1 file changed, 13 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/acpi/platform_profile.c 
>> b/drivers/acpi/platform_profile.c
>> index fc92e43d0fe9..1b6317f759f9 100644
>> --- a/drivers/acpi/platform_profile.c
>> +++ b/drivers/acpi/platform_profile.c
>> @@ -260,14 +260,14 @@ static int _aggregate_choices(struct device *dev, 
>> void *data)
>> 
>>  /**
>>   * platform_profile_choices_show - Show the available profile choices 
>> for legacy sysfs interface
>> - * @dev: The device
>> + * @kobj: The kobject
>>   * @attr: The attribute
>>   * @buf: The buffer to write to
>>   *
>>   * Return: The number of bytes written
>>   */
>> -static ssize_t platform_profile_choices_show(struct device *dev,
>> -					     struct device_attribute *attr,
>> +static ssize_t platform_profile_choices_show(struct kobject *kobj,
>> +					     struct kobj_attribute *attr,
>>  					     char *buf)
>>  {
>>  	unsigned long aggregate[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
>> @@ -333,14 +333,14 @@ static int _store_and_notify(struct device *dev, 
>> void *data)
>> 
>>  /**
>>   * platform_profile_show - Show the current profile for legacy sysfs interface
>> - * @dev: The device
>> + * @kobj: The kobject
>>   * @attr: The attribute
>>   * @buf: The buffer to write to
>>   *
>>   * Return: The number of bytes written
>>   */
>> -static ssize_t platform_profile_show(struct device *dev,
>> -				     struct device_attribute *attr,
>> +static ssize_t platform_profile_show(struct kobject *kobj,
>> +				     struct kobj_attribute *attr,
>>  				     char *buf)
>>  {
>>  	enum platform_profile_option profile = PLATFORM_PROFILE_LAST;
>> @@ -362,15 +362,15 @@ static ssize_t platform_profile_show(struct device *dev,
>> 
>>  /**
>>   * platform_profile_store - Set the profile for legacy sysfs interface
>> - * @dev: The device
>> + * @kobj: The kobject
>>   * @attr: The attribute
>>   * @buf: The buffer to read from
>>   * @count: The number of bytes to read
>>   *
>>   * Return: The number of bytes read
>>   */
>> -static ssize_t platform_profile_store(struct device *dev,
>> -				      struct device_attribute *attr,
>> +static ssize_t platform_profile_store(struct kobject *kobj,
>> +				      struct kobj_attribute *attr,
>>  				      const char *buf, size_t count)
>>  {
>>  	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
>> @@ -401,12 +401,12 @@ static ssize_t platform_profile_store(struct device *dev,
>>  	return count;
>>  }
>> 
>> -static DEVICE_ATTR_RO(platform_profile_choices);
>> -static DEVICE_ATTR_RW(platform_profile);
>> +static struct kobj_attribute attr_platform_profile_choices = 
>> __ATTR_RO(platform_profile_choices);
>> +static struct kobj_attribute attr_platform_profile = 
>> __ATTR_RW(platform_profile);
>> 
>>  static struct attribute *platform_profile_attrs[] = {
>> -	&dev_attr_platform_profile_choices.attr,
>> -	&dev_attr_platform_profile.attr,
>> +	&attr_platform_profile_choices.attr,
>> +	&attr_platform_profile.attr,
>>  	NULL
>>  };
>> 
>>
>> ---
>> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
>> change-id: 20240819-acpi-platform_profile-fix-cfi-violation-de278753bd5f
>>
>> Best regards,
>> -- 
>> Nathan Chancellor <nathan@kernel.org>
>
> Just a note to say thank you for noticing my email address change - the 
> old lenovo one was awful to use so I dropped it a while back, but it 
> meant I missed your first two patches (my mail filters for the list 
> should have caught it and I'll have to figure out why not...)
>
> From the V1 patch there was a question about why it was done this way: 
> I believe I just copied how it seems to be done everywhere else in the 
> kernel. I can't remember what I used as a reference exactly, but I went 
> and checked a few random drivers and it seems to be everywhere.
>
> Patch looks fine (I'd like to try it out on my system - will aim to do 
> that today). I didn't know what CFI was (and have lightly educated 
> myself now). 
> Is there a better way to fix this so it's common across all drivers 
> somehow? Updating every individual instance is going to be a lot.
>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>
Also:
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Mark

